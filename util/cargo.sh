#!/usr/bin/env bash

echo "installing rustup"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

echo "installing rust binaries"
cargo install --locked bat
cargo install --locked deno
cargo install --locked pueue
cargo install --locked sheldon
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
  starship \
  topgrade \
  tree-rs \
  xcompress \
  zoxide
