#!/usr/bin/env bash

echo "setting Node to latest LTS version"
eval "$(/home/node/.cargo/bin/fnm env)"
source ~/.bashrc
/home/node/.cargo/bin/fnm install 16
/home/node/.cargo/bin/fnm use 16

echo "installing global npm dependencies"
pnpm install -g @angular/cli eslint fkill-cli glyphhanger next prettier serve tailwindcss typescript
