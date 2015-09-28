#!/bin/bash

scrot /tmp/screen.png
convert /tmp/screen.png -scale 5% -scale 2000% /tmp/screen.png
convert /tmp/screen.png /home/kenyonj/.i3/lock.png -gravity center -composite -matte /tmp/screen.png
i3lock -i /tmp/screen.png
rm /tmp/screen.png
