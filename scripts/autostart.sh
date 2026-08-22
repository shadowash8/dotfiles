#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
swayidle -w \
      timeout 300 "systemctl suspend" \
      before-sleep "gtklock" &
kdeconnectd &
wlsunset -o eDP-1 -l 19 -L 74 -g 0.8 &
wl-paste --watch cliphist store &
waybar &
swaybg -i $(<~/.cache/ashwal/ashwal) -m fill &

