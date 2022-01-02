#!/usr/bin/env bash

echo "setting Node to latest LTS version"
~/.cargo/bin/fnm install --lts
~/.cargo/bin/fnm use $(~/.cargo/bin/fnm list | ~/.cargo/bin/sd "\*\s" "" | ~/.cargo/bin/sd "\n" "" | ~/.cargo/bin/sd "%" "" | ~/.cargo/bin/sd ".*v(\d+\.\d+\.\d+)\slts-.*" '$1')

echo "installing global npm dependencies"
npm install -g eslint fkill-cli glyphhanger prettier serve
