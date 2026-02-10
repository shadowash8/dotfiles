#!/bin/sh

# Source pywal colors
. "${HOME}/.cache/wal/colors.sh"

# Get the wallpaper path from the cache file
# (The $(cat ...) reads the path inside that file)
WAL_PATH=$(cat "${HOME}/.cache/wal/wal")

swaylock \
  --image "$WAL_PATH" \
  --clock \
  --indicator \
  --indicator-radius 120 \
  --indicator-thickness 10 \
  --datestr "%A, %d %b" \
  --timestr "%I:%M" \
  --font "SF Mono" \
  --ring-color "$color4" \
  --inside-color 00000000 \
  --line-color 00000000 \
  --key-hl-color "$color2" \
  --text-color "$foreground" \
  --effect-blur 7x5 \
  --fade-in 0.2
