#!/usr/bin/env bash

set -euo pipefail

SOURCE="/home/ashwin/documents/personal/"
DEST="/run/media/ashwin/HDD/Documents/"

# Verify source exists
if [[ ! -d "$SOURCE" ]]; then
    echo "ERROR: Source directory not found:"
    echo "  $SOURCE"
    exit 1
fi

# Verify destination exists (HDD is mounted)
if [[ ! -d "$DEST" ]]; then
    echo "Destination does not exist:"
    echo "  $DEST"
    exit 1
fi

echo "========================================"
echo "Documents Mirror Backup"
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
echo "Mirror sync completed successfully."
