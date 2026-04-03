#!/bin/bash

LOCAL_PATH="$HOME/moosic"
MIRROR_PATH="/mnt/personal/Areas/Music"


if [ -d "$MIRROR_PATH" ]; then
  rsync -rtv --progress --modify-window=1 --delete "$LOCAL_PATH/" "$MIRROR_PATH"
  echo "Your music library is backed up!"
else
  echo "Check your mount! /mnt/personal isn't active."
fi
