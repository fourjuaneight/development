#!/usr/bin/env bash

echo 'export PATH=$HOME/.fnm:$PATH' >> .bashrc
echo 'export PATH=$HOME/.fnm:$PATH' >> .profile
eval "`fnm env`"

echo "setting Node to latest LTS version"
fnm use 16.13.0

echo "installing global npm dependencies"
npm i -g eslint fkill-cli glyphhanger prettier
