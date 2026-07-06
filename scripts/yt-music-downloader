#!/bin/bash

echo "--------------------------------------"
echo "      YouTube Music Downloader        "
echo "  Optimized for singles and albums    "
echo "--------------------------------------"

# --- Get URL ---
if [ -z "$1" ]; then
    read -p "Enter YouTube song or album URL: " URL
else
    URL="$1"
fi

# --- Validate URL ---
if [[ ! "$URL" =~ ^https:// ]]; then
    echo "Invalid URL. Must start with https://"
    exit 1
fi

# --- Convert music.youtube.com to youtube.com ---
# This uses bash string substitution: ${variable/search/replace}
if [[ "$URL" == *"music.youtube.com"* ]]; then
    echo "Detected YouTube Music URL, converting to normal YouTube URL..."
    URL="${URL/music.youtube.com/www.youtube.com}"
fi

# --- Get output folder ---
if [ -z "$2" ]; then
    read -p "Enter output folder (leave empty for $HOME/Music): " OUTPUT_DIR
    if [ -z "$OUTPUT_DIR" ]; then
        OUTPUT_DIR="$HOME/Music"
    fi
else
    OUTPUT_DIR="$2"
fi

# --- Create output directory if missing ---
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# --- Download audio only ---
echo "Downloading audio..."
# Note: Using / instead of \ for paths in Linux/macOS
yt-dlp -o "$OUTPUT_DIR/%(title)s.%(ext)s" \
       -f "bestaudio[ext=opus]/bestaudio" \
       --extract-audio \
       --audio-format opus \
       --audio-quality 0 \
       "$URL"

# --- Check Exit Status ---
if [ $? -eq 0 ]; then
    echo -e "\nDone! Files saved in \"$OUTPUT_DIR\""
else
    echo -e "\nSome files may have failed. Check yt-dlp output."
fi

# Wait for user input before closing (similar to PAUSE)
read -p "Press Enter to exit..."
