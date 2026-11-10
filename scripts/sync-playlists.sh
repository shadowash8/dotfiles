#!/bin/bash

# Configuration
SOURCE_DIR="$HOME/Music/Playlists"
MIRROR_DIR="$HOME/Documents/Music/Playlists"

# Safegaurd: Ensure directories exist before searching so 'find' never errors out
mkdir -p "$SOURCE_DIR"
mkdir -p "$MIRROR_DIR"

echo "Starting Two-Way Playlist Sync..."

# 1. PC to Phone (FLAC -> OPUS)
find "$SOURCE_DIR" -maxdepth 1 -type f -name "*.m3u" -print0 | while IFS= read -r -d '' src_file; do
    rel_path="${src_file#$SOURCE_DIR/}"
    mir_file="$MIRROR_DIR/$rel_path"

    if [ ! -f "$mir_file" ] || [ "$src_file" -nt "$mir_file" ]; then
        echo "Pushing to Phone: $rel_path"
        mkdir -p "$(dirname "$mir_file")"
        sed 's/\.flac/\.opus/g' "$src_file" > "$mir_file"
        touch -r "$src_file" "$mir_file"
    fi
done

# 2. Phone to PC (OPUS -> FLAC)
find "$MIRROR_DIR" -maxdepth 1 -type f -name "*.m3u" -print0 | while IFS= read -r -d '' mir_file; do
    rel_path="${mir_file#$MIRROR_DIR/}"
    src_file="$SOURCE_DIR/$rel_path"

    if [ ! -f "$src_file" ] || [ "$mir_file" -nt "$src_file" ]; then
        echo "Pulling from Phone: $rel_path"
        mkdir -p "$(dirname "$src_file")"
        sed 's/\.opus/\.flac/g' "$mir_file" > "$src_file"
        touch -r "$mir_file" "$src_file"
    fi
done

echo "Playlist sync complete."
