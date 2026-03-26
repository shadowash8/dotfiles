#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
hypridle &
dunst &
dbus-launch waybar &
swaybg -i $(cat ~/.cache/ashwal/ashwal) &
wlsunset -o eDP-1 -g 0.8 &

# Clipboard stuff
cliphist wipe &
wl-paste --watch cliphist store &

