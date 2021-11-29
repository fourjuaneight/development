#!/usr/bin/env bash

echo 'export SHELDON_CONFIG_DIR="$HOME/.config/sheldon"' >> .bashrc
echo 'export SHELDON_CONFIG_DIR="$HOME/.config/sheldon"' >> .profile
echo 'export SHELDON_DATA_DIR="$SHELDON_CONFIG_DIR"' >> .bashrc
echo 'export SHELDON_DATA_DIR="$SHELDON_CONFIG_DIR"' >> .profile
echo 'export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"' >> .bashrc
echo 'export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"' >> .profile
echo 'export SHELDON_LOCK_FILE="$SHELDON_CONFIG_DIR/plugins.lock"' >> .bashrc
echo 'export SHELDON_LOCK_FILE="$SHELDON_CONFIG_DIR/plugins.lock"' >> .profile
echo 'export SHELDON_CLONE_DIR="$SHELDON_DATA_DIR/repos"' >> .bashrc
echo 'export SHELDON_CLONE_DIR="$SHELDON_DATA_DIR/repos"' >> .profile
echo 'export SHELDON_DOWNLOAD_DIR="$SHELDON_DATA_DIR/downloads"' >> .bashrc
echo 'export SHELDON_DOWNLOAD_DIR="$SHELDON_DATA_DIR/downloads"' >> .profile
echo 'eval "$(sheldon source)"' >> .bashrc
echo 'eval "$(sheldon source)"' >> .profile

echo "installing zsh plugins via sheldon"
/home/node/.cargo/bin/sheldon lock
