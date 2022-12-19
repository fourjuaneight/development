#!/usr/bin/env bash

echo "updating apt-get directories"
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -f
apt-get autoremove -y

echo "installing dependencies"
apt-get install -y \
  ansible \
  apt-transport-https \
  bash \
  build-essential \
  ca-certificates \
  certbot \
  clang \
  cmake \
  coreutils \
  curl \
  findutils \
  font-manager \
  fontconfig \
  gawk \
  ghc \
  gifsicle \
  gist \
  git \
  git-lfs \
  gnupg \
  gpg \
  graphicsmagick \
  id3v2 \
  imagemagick \
  indent \
  indicator-multiload \
  inotify-tools \
  jasper \
  jpegoptim \
  libfontconfig1-dev \
  libfreetype6-dev \
  libjpeg8 \
  libmemcached-tools \
  libncursesw5-dev \
  libpng-dev \
  libreadline-dev \
  libreadline6-dev \
  libsecret-1-0 \
  libsecret-1-dev \
  libvips \
  libvips-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  libvips \
  lsb-release \
  libvips-dev \
  lua5.4 \
  mc \
  mediainfo \
  memcached \
  mercurial \
  mkvtoolnix \
  mmv \
  mosh \
  ncdu \
  nginx \
  perl \
  pkg-config \
  pandoc \
  perl \
  pngquant \
  poppler-utils \
  postgresql \
  python-pygments \
  python3 \
  python3-dev \
  python3-pip \
  python-pygments \
  ripgrep \
  rsync \
  sed \
  silversearcher-ag \
  stow \
  tar \
  tmux \
  tree \
  unrar \
  vim \
  virtualenv \
  wget \
  xsel \
  xz-utils \
  zfsutils-linux \
  zsh

apt install -y pkg-config libssl-dev

echo "cleaning up"
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
