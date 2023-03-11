#!/usr/bin/env bash
set -e

eval $(xdotool getmouselocation --shell)
xdotool search --desktop 0 --name "Firefox" windowactivate
xdotool mousemove 1248 53
xdotool click 1
xdotool mousemove "$X" "$Y"
