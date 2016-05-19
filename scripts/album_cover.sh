#!/bin/zsh

no_album_art_found_image="$HOME/.scripts/notfound.jpg"
current_song_artist=$(mpc current -f %artist% | sed 's/[ ,;]/+/g')
current_song_album=$(mpc current -f %album% | sed 's/[ ,;]/+/g')
current_song_title=$(mpc current -f %title% | sed 's/[ ,;]/+/g')
current_file=$(mpc current -f %file%)
array=("${(@s/:/)current_file}")
song_source=$array[1]
song_id=$array[3]
itunes_api_url="https://itunes.apple.com/search?term=$current_song_artist+$current_song_album&country=US"
alt_itunes_api_url="https://itunes.apple.com/search?term=$current_song_artist+$current_song_title&country=US"
spotify_api_url="https://api.spotify.com/v1/tracks/$song_id"

if [[ "$song_source" == "spotify" ]]; then
  image_url=$(curl -X GET "$spotify_api_url" | jsawk 'return this.album.images[0].url')
  curl "$image_url" -o /tmp/cover.jpg
else
  result_count=$(curl -X GET "$itunes_api_url" | jsawk 'return this.resultCount')

  if [[ "$result_count" > 0 ]]; then
    image_url=$(curl -X GET "$itunes_api_url" | jsawk 'return this.results[0].artworkUrl100')
    curl "$image_url" -o /tmp/cover.jpg
  else
    result_count=$(curl -X GET "$alt_itunes_api_url" | jsawk 'return this.resultCount')

    if [[ "$result_count" > 0 ]]; then
      image_url=$(curl -X GET "$alt_itunes_api_url" | jsawk 'return this.results[0].artworkUrl100')
      curl "$image_url" -o /tmp/cover.jpg
    else
      cp $no_album_art_found_image /tmp/cover.jpg
    fi
  fi
fi
