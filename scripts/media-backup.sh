#!/usr/bin/env bash

set -euo pipefail

SOURCE="/home/ashwin/documents/media/"
DEST="/run/media/ashwin/HDD/Media/"

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
echo "Media Mirror Backup"
echo "========================================"
echo "Source      : $SOURCE"
echo "Destination : $DEST"
echo

read -rp "Start sync? [y/N] " answer
[[ "$answer" =~ ^[Yy]$ ]] || exit 0

rsync \
    -a \
    -h \
    --delete \
    --itemize-changes \
    --progress \
    --stats \
    "$SOURCE" \
    "$DEST"

echo
echo "Media mirror completed successfully."
