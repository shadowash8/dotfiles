#!/usr/bin/env bash

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=ashwc
systemctl start --user ashwc-session.target
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & 
systemctl --user start xdg-desktop-portal-wlr xdg-desktop-portal
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
