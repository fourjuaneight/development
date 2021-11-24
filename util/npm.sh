#!/usr/bin/env bash

echo 'export PATH=$HOME/.fnm:$PATH' >> .bashrc
echo 'export PATH=$HOME/.fnm:$PATH' >> .profile
eval "`~/.cargo/bin/fnm env`"

echo "setting Node to latest LTS version"
~/.cargo/bin/fnm install 16.13.0
~/.cargo/bin/fnm use 16.13.0

echo "installing global npm dependencies"
npm install -g eslint fkill-cli glyphhanger prettier
