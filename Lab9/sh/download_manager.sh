#!/bin/bash

for file in *; do
  # Skip directories
  if [ -f "$file" ]; then
    EXT="${file##*.}"

    # If file has no extension
    if [ "$EXT" = "$file" ]; then
      FOLDER="others"
    else
      FOLDER="$EXT"
    fi

    mkdir -p "$FOLDER"
    mv "$file" "$FOLDER/"
  fi
done

echo "Files organized successfully!"
