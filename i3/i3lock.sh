#!/bin/bash

scrot /tmp/screen_locked.png
convert -scale 5% -scale 2000% /tmp/screen_locked.png /tmp/screen_locked2.png
i3lock -i /tmp/screen_locked2.png
