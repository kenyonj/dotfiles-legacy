#!/bin/bash
# i3 autostart

setxkbmap -option ctrl:nocaps
xautolock -time 15 -locker '~/.i3/i3lock.sh' &
