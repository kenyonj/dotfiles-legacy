#!/bin/sh

while :; do
  [ -e /tmp/cover.jpg ] && break
  wait 1
done

feh --title albumart --geometry 100x100 --zoom fill --reload 1 /tmp/cover.jpg
