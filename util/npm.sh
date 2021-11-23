#!/usr/bin/env bash

echo "updating Node modules install directory"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo 'export PATH=$HOME/.fnm:$PATH' >> .bashrc
echo 'export PATH=$HOME/.fnm:$PATH' >> .profile
echo 'eval "`fnm env`"' >> .bashrc
echo 'eval "`fnm env`"' >> .profile

echo "installing global npm dependencies"
npm i -g eslint fkill-cli glyphhanger postcss prettier
