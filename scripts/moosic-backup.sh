#!/usr/bin/env bash

set -euo pipefail

SOURCE="$HOME/moosic/"
DEST="/run/media/ashwin/HDD/Personal/Music/"

# Verify source exists
if [[ ! -d "$SOURCE" ]]; then
    echo "ERROR: Source directory not found:"
    echo "  $SOURCE"
    exit 1
fi

# Verify destination exists (HDD is mounted)
if [[ ! -d "$DEST" ]]; then
    echo "ERROR: Destination directory not found."
    echo "Is your HDD mounted?"
    echo "  $DEST"
    exit 1
fi

echo "========================================"
echo "Music Mirror Backup"
echo "========================================"
echo "Source      : $SOURCE"
echo "Destination : $DEST"
echo

read -rp "Start sync? [y/N] " answer
[[ "$answer" =~ ^[Yy]$ ]] || exit 0

rsync \
    -a \
    -h \
    --modify-window=1 \
    --delete \
    --itemize-changes \
    --progress \
    --stats \
    "$SOURCE" \
    "$DEST"

echo
echo "Music mirror completed successfully."

