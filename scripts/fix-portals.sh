#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=nauka

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE

systemctl --user restart \
    xdg-desktop-portal \
    xdg-desktop-portal-wlr \
    hypr-kdeconnect-portal

systemctl --user start nauka-session.target
