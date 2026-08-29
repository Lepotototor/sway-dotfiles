#!/usr/bin/env bash
# Usage : screenshot.sh area   -> take a region
#         screenshot.sh full   -> whole screen

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$1" in
  area)
    GEOM=$(slurp) || exit 1
    grim -g "$GEOM" "$FILE"
    ;;
  full|*)
    grim "$FILE"
    ;;
esac

if [ -f "$FILE" ]; then
  wl-copy < "$FILE"
  notify-send "Screenshot" "Saved in clipboard\nSaved as : $FILE" -i "$FILE"
else
  notify-send "Screenshot" "Failed"
fi
