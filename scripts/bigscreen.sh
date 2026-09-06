#/bin/bash

# Environment variables
export QT_QUICK_CONTROLS_STYLE=org.kde.breeze
export QT_ENABLE_GLYPH_CACHE_WORKAROUND=1
export QT_QUICK_CONTROLS_MOBILE=true
export PLASMA_INTEGRATION_USE_PORTAL=1
export PLASMA_PLATFORM=mediacenter
export QT_FILE_SELECTORS=mediacenter

# Set ~/.config/plasma-bigscreen/... as location for default bigscreen configs (i.e. envmanager generated)
export XDG_CONFIG_DIRS="$HOME/.config/plasma-bigscreen:/etc/xdg:$XDG_CONFIG_DIRS"

# ensure that we have our environment settings set properly prior to the shell being loaded (otherwise there is a race condition with autostart)
QT_QPA_PLATFORM=offscreen plasma-bigscreen-envmanager --apply-settings

export PLASMA_DEFAULT_SHELL=org.kde.plasma.bigscreen
dbus-run-session kwin_wayland "plasmashell -p org.kde.plasma.bigscreen"
