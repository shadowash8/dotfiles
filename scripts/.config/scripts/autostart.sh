#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
swayidle &
dunst &
wlsunset -o eDP-1 -l 19 -L 74 -g 0.8 &

# Clipboard stuff
wl-paste --watch cliphist store &

