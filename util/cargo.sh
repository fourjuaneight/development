#!/usr/bin/env bash

echo "installing rustup"
source $HOME/.cargo/env
rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

echo "installing rust binaries"
cargo install --locked bat
cargo install --locked pueue
cargo install --locked sheldon
cargo install --locked starship
cargo install cargo-update \
  exa \
  fd-find \
  fnm \
  git-cliff \
  git-delta \
  git-interactive-rebase-tool \
  os_info_cli \
  ripgrep \
  rm-improved \
  sd \
  topgrade \
  tree-rs \
  xcompress \
  zoxide
