#!/bin/bash

# Path to your keybinds file
KEYBINDS_FILE="$HOME/.config/hypr/res/keybinds.conf"

# 1. Parse the file
# - Search for lines starting with 'bind'
# - Replace '$mainMod' with 'SUPER' for readability
# - Use awk to format the output into: KEY COMBO -> ACTION
list_binds() {
    grep -E '^bind[a-z]*\s*=' "$KEYBINDS_FILE" | \
    sed 's/\$mainMod/SUPER/g' | \
    awk -F ',' '{
        # Clean up whitespace
        gsub(/^[ \t]+|[ \t]+$/, "", $2); 
        gsub(/^[ \t]+|[ \t]+$/, "", $3);
        gsub(/^[ \t]+|[ \t]+$/, "", $4);
        gsub(/^[ \t]+|[ \t]+$/, "", $5);
        
        # If it is a standard bind, $2 is Mod, $3 is Key, $4+ is command
        if ($4 != "") {
            printf "%-20s -> %s %s\n", $2 " + " $3, $4, $5
        }
    }'
}

# 2. Show in Rofi
# We use a mono font theme string to keep the arrows aligned
list_binds | rofi -dmenu -i -p "Keybinds" \
    -theme-str 'listview { lines: 15; }' \
