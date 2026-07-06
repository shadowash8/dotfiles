#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar/"

# 1. Get a list of folders, excluding 'res' or hidden folders
themes=($(find "$WAYBAR_DIR" -maxdepth 1 -type d -not -path "$WAYBAR_DIR" -not -name "res" -not -name ".*" -printf "%f\n"))

# Check if a theme was provided as an argument
if [[ -z "$1" ]]; then
    echo "Available themes:"
    for theme in "${themes[@]}"; do
        echo "  - $theme"
    done
    echo -e "\nUsage: waybar-themes.sh [theme_name]"
    exit 1
fi

SELECTED=$1

# 2. Check if the selected theme exists in our array
if [[ ! " ${themes[@]} " =~ " ${SELECTED} " ]]; then
    echo "Error: Theme '$SELECTED' not found."
    exit 1
fi

# 3. Find the config and css files inside the selected folder
# This handles your inconsistent naming (like config_rounded.jsonc)
NEW_CONFIG=$(find "$WAYBAR_DIR/$SELECTED" -name "*.jsonc" | head -n 1)
NEW_STYLE=$(find "$WAYBAR_DIR/$SELECTED" -name "*.css" | head -n 1)

if [[ -z "$NEW_CONFIG" || -z "$NEW_STYLE" ]]; then
    echo "Error: Could not find both a .jsonc and .css file in $SELECTED"
    exit 1
fi

# 4. Create the symlinks
ln -sf "$NEW_CONFIG" "$WAYBAR_DIR/config.jsonc"
ln -sf "$NEW_STYLE" "$WAYBAR_DIR/style.css"

# 5. Restart Waybar
killall waybar
waybar & disown

echo "Successfully switched to $SELECTED!"
