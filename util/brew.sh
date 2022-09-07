#!/usr/bin/env bash

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

echo "turning off analytics"
brew analytics off

echo "updating homebrew directories"
brew update

echo "installing packages"
brew tap helix-editor/helix
brew install helix
brew install ack cocoapods fzf gcc@5 gh go gum hugo pnpm webp

echo "cleaning up"
brew cleanup
