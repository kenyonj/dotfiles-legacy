#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP1 --off --output DP2-1 --off --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2-2-1 --off --output DP2-2-8 --off --output DP2 --off
xrandr --output eDP1 --primary
xrandr --output eDP1 --mode 1920x1080 --scale 1x1
