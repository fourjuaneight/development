#!/usr/bin/env bash

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

echo "turning off analytics"
brew analytics off

echo "updating homebrew directories"
brew update

echo "installing packages"
brew install ack cocoapods fzf gcc@5 gh hugo webp

echo "cleaning up"
brew cleanup
