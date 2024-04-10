#!/usr/bin/env bash

echo "installing rustup"
source $HOME/.cargo/env
rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

echo "installing autin"
bash <(curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh)

echo "installing rust binaries"
cargo install --locked bat
cargo install --locked pueue
cargo install --locked sheldon
cargo install --locked starship
cargo install bottom \
  cargo-update \
  coreutils \
  exa \
  fd-find \
  fnm \
  frum \
  git-absorb \
  git-cliff \
  git-delta \
  git-interactive-rebase-tool \
  halp \
  os_info_cli \
  procs \
  ripgrep \
  rm-improved \
  sd \
  skim \
  stdrename \
  topgrade \
  tree-rs \
  xcompress \
  zoxide
