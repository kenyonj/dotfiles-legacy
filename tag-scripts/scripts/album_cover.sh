#!/bin/zsh

ITUNES_BASE_URL="https://itunes.apple.com/search?country=US&term="
SPOTIFY_BASE_URL="https://api.spotify.com/v1/tracks/"
NO_ALBUM_ART_FOUND_IMAGE="$HOME/.scripts/notfound.jpg"

api_url_for() {
  if [[ "$1" == "spotify" ]]; then
    echo "$SPOTIFY_BASE_URL`current_song_detail id`"
  elif [[ "$1" == "itunes" ]]; then
    echo "$ITUNES_BASE_URL$(current_song_detail artist)+$(current_song_detail album)"
  elif [[ "$1" == "itunes-alt" ]]; then
    echo "$ITUNES_BASE_URL$(current_song_detail artist)+$(current_song_detail title)"
  fi
}

current_song_detail() {
  if [[ "$1" == "file" ]]; then
    mpc current -f %file%
  elif [[ "$1" == "source" || "$1" == "id" ]]; then
    local current_file=$(mpc current -f %file%)
    local split_current_file=("${(@s/:/)current_file}")

    if [[ "$1" == "source" ]]; then
      echo $split_current_file[1]
    elif [[ "$1" == "id" ]]; then
      echo $split_current_file[3]
    fi
  else
    mpc current -f %$1% | sed 's/[ ,;]/+/g'
  fi
}

find_cover_image() {
  if [[ "`current_song_detail source`" == "spotify" ]]; then
    echo "$(get_image_url_from spotify)"
  else
    if [[ "`result_count_from itunes`" > 0 ]]; then
      echo "$(get_image_url_from itunes)"
    else
      if [[ "`result_count_from itunes-alt`" > 0 ]]; then
        echo "$(get_image_url_from itunes-alt)"
      else
        echo "none found"
      fi
    fi
  fi
}

get_image_url_from() {
  if [[ "$1" == "spotify" ]]; then
    curl -X GET $(api_url_for spotify) | ~/.local/bin/jsawk 'return this.album.images[0].url'
  else
    curl -X GET $(api_url_for $1) | ~/.local/bin/jsawk 'return this.results[0].artworkUrl100'
  fi
}

result_count_from() {
  echo "`curl -X GET $(api_url_for $1) | ~/.local/bin/jsawk 'return this.resultCount'`"
}

set_cover_image() {
  if [[ "$1" == "none found" ]]; then
    cp $NO_ALBUM_ART_FOUND_IMAGE /tmp/cover.jpg
  else
    curl $1 -o /tmp/cover.jpg
  fi
}

set_cover_image "`find_cover_image`"
