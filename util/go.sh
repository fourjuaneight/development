#!/usr/bin/env bash

echo "installing go binaries"
for pkg in $(bat -p go-packages.txt); do
  name=$(echo "$pkg" | sed 's/github\.com\///g')
  echo "$name";
  go install $pkg@latest
done
