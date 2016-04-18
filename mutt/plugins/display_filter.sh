#!/usr/bin/env sh

tmp_file="/tmp/mutt.txt"
cat - > "$tmp_file"

tmp_date=$(formail -x Date < "$tmp_file")
local_date=$(date -d "$tmp_date" +"%a, %d %b %Y %H:%M:%S")
message=$(formail -f -I "Date: $local_date" < "$tmp_file")

if echo "${message}" | fgrep --silent "From: Trello"; then
  echo "${message}" | /home/kenyonj/.local/bin/trelloparse | fold -s | recode html
else
  echo "${message}"
fi
