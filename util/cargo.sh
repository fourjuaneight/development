#!/usr/bin/env bash

echo "installing rustup"
source $HOME/.cargo/env
rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

echo "installing rust binaries"
cargo install --locked bat
cargo install --locked deno
cargo install --locked sheldon
cargo install cargo-update \
  exa \
  fd-find \
  fnm \
  git-delta \
  git-interactive-rebase-tool \
  os_info_cli \
  ripgrep \
  sd \
  starship \
  tree-rs \
  xcompress \
  zoxide