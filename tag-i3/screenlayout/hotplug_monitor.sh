#!/usr/bin/bash

export DISPLAY=:0

function connect(){
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --mode 2560x1600 --pos 0x0 --rotate normal --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 2560x296 --rotate normal --output VGA1 --off
}

function disconnect(){
  xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 192x132 --rotate normal --output VGA1 --off
}

xrandr | grep "DP1 connected" &> /dev/null && connect || disconnect
