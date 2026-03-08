#!/bin/bash

# Define paths
ANIM_DIR="$HOME/.config/hypr/res/animations"
TARGET_CONF="$HOME/.config/hypr/res/animations.conf"

# Get the list of files and strip the .conf extension for a cleaner UI
choice=$(ls "$ANIM_DIR" | sed 's/\.conf$//' | rofi -dmenu -p "Select Animation Profile:")

# If the user made a choice (didn't press Esc)
if [ -n "$choice" ]; then
    # Copy the selected file to the main animations.conf
    cat "$ANIM_DIR/$choice.conf" > "$TARGET_CONF"
    
    # Optional: Send a notification
    notify-send "Hyprland" "Animation profile '$choice' applied."
fi
