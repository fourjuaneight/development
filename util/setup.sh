#!/usr/bin/env bash

echo "installing zsh plugings"
sheldon lock

echo "setting Github CLI editor"
gh config set editor vim

echo "saving VSCode themes"
cp vscode-dracula.vsix ~/.vscode/extensions

echo "installing vim plug"
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PluginInstall +qall