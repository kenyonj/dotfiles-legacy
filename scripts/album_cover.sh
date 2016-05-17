#!/bin/sh

current_file=$(mpc current -f %file%)
ffmpeg -y -i "$HOME/music/$current_file" /tmp/cover.jpg
