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
brew install ack cocoapods fzf gcc@5 gh go gum hugo pnpm rclone webp yq yt-dlp/taps/yt-dlp

echo "cleaning up"
brew cleanup
