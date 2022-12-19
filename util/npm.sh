#!/usr/bin/env bash

echo "setting Node to latest LTS version"
eval "$(fnm env)"
source ~/.bashrc
/home/node/.cargo/bin/fnm install 16
/home/node/.cargo/bin/fnm use 16

echo "installing global npm dependencies"
npm install -g eslint fkill-cli glyphhanger prettier serve typescript
