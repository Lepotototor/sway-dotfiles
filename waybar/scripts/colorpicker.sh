#!/usr/bin/env bash

COLOR=$(hyprpicker -a)

if [ -n "$COLOR" ]; then
  notify-send "Color-Picker" "Copy in clipboard: $COLOR"
else
  notify-send "Color-Picker" "Failed"
fi
