#!/usr/bin/env bash

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

echo "turning off analytics"
brew analytics off

echo "updating homebrew directories"
brew update

echo "installing complicated packages"
brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-fdk-aac
brew tap helix-editor/helix
brew install helix

echo "installing packages"
brew install ack
brew install charmbracelet/tap/mods
brew install cocoapods
brew install dive
brew install dog
brew install fx
brew install fzf
brew install gcc@5
brew install gh
brew install glow
brew install go
brew install gum
brew install hugo
brew install knqyf263/pet/pet
brew install lindell/multi-gitter/multi-gitter
brew install lux
brew install neovim
brew install osv-scanner
brew install pnpm
brew install rclone
brew install restic
brew install syncthing
brew install tpm
brew install uv
brew install webp
brew install yq

echo "cleaning up"
brew cleanup
