#!/usr/bin/env bash

echo "saving fonts"
for file in ./fonts/**/*; do
  cp "$file" ~/.local/share/fonts
done
echo "done saving fonts."

echo "building font chaches"
fc-cache -f -v
echo "done building chaches."
