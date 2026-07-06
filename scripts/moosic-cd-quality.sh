#!/bin/bash

# 1. Create the target dir
mkdir -p compressed

# 2. Convert the audio (The Sane Way)
for f in *.flac; do
    ffmpeg -i "$f" -sample_fmt s16 -ar 44100 -compression_level 12 "compressed/$f" -y
done

# 3. Copy the non-audio stuff (Lyrics, Covers, Playlists)
cp *.lrc *.jpg *.png *.m3u compressed/ 2>/dev/null

echo "---"
echo "Compression done. Check the 'compressed' folder."
echo "Original size: $(du -sh . | cut -f1)"
echo "New size:      $(du -sh compressed | cut -f1)"
