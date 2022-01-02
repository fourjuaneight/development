#!/usr/bin/env bash

echo "saving fonts"
for folder in ./fonts/**; do
  mv "$folder" /usr/share/fonts
done
echo "done saving fonts."

echo "building font chaches"
fc-cache -f -v
echo "done building chaches."
