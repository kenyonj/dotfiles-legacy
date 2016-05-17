#!/bin/sh

while :; do
  [ -e /tmp/cover.jpg ] && break
  wait 1
done

feh --title albumart --geometry 300x300 --zoom fill --reload 1 /tmp/cover.jpg
