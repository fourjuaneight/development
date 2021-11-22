#!/usr/bin/env bash

echo "installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> .bashrc
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> .profile
source $HOME/.cargo/env
rustup toolchain install nightly --allow-downgrade --profile minimal --component clippy

echo "installing rust binaries"
cargo install --locked bat
cargo install cargo-cache \
  cargo-update \
  exa \
  fd-find \
  fnm \
  git-cliff \
  git-delta \
  ripgrep \
  sheldon \
  starship \
  stdrename \
  wrangler \
  zellij \
  zoxide
