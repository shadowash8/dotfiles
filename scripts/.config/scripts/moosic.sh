#!/bin/bash

# Configuration
SOURCE_DIR="/mnt/personal/Areas/Music"
MIRROR_DIR="/home/ashwin/moosic"

# Ensure the source exists so we don't do something stupid
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory not found."
    exit 1
fi

echo "Starting the Smooth Operation. Sit tight."

# Use 'find' with -print0 to handle spaces in filenames (don't be a rookie)
find "$SOURCE_DIR" -type f -name "*.flac" -print0 | while IFS= read -r -d '' file; do

    # Calculate the relative path from the source root
    rel_path="${file#$SOURCE_DIR/}"

    # Define the target path (swap .flac for .opus)
    target_path="$MIRROR_DIR/${rel_path%.flac}.opus"

    # 1. Create the subfolder structure in the mirror
    mkdir -p "$(dirname "$target_path")"

    # 2. Check if the file already exists to save time
    if [ ! -f "$target_path" ]; then
        echo "Converting: $rel_path"
        # -n tells ffmpeg not to overwrite; -v warning keeps the logs clean
        ffmpeg -v warning -n -i "$file" -c:a libopus -b:a 320k -map_metadata 0 "$target_path" < /dev/null
    else
        echo "Skipping: $rel_path (Already exists)"
    fi
done

echo "Done. Your library is now as lean as the smooth operator."
