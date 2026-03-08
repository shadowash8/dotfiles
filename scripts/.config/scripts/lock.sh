#!/bin/sh

# Source pywal colors
. "${HOME}/.cache/cwal/colors.sh"

# Get the wallpaper path from the cache file
# (The $(cat ...) reads the path inside that file)

swaylock \
  --image "$wallpaper" \
  --clock \
  --indicator \
  --indicator-radius 120 \
  --indicator-thickness 10 \
  --datestr "%A, %d %b" \
  --timestr "%I:%M" \
  --font "sans" \
  --ring-color "$color4" \
  --inside-color 00000000 \
  --line-color 00000000 \
  --key-hl-color "$color2" \
  --text-color "$foreground" \
  --fade-in 0
