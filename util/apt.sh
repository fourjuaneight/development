#!/usr/bin/env bash

echo "updating apt-get directories"
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -f
apt-get autoremove -y

echo "installing dependencies"
apt-get install -y \
  ca-certificates \
  certbot \
  clang \
  cmake \
  coreutils \
  findutils \
  font-manager \
  fontconfig \
  gawk \
  ghc \
  gist \
  git \
  gnupg \
  golang-go \
  gpg \
  graphicsmagick \
  imagemagick \
  indent \
  indicator-multiload \
  inotify-tools \
  jasper \
  libfontconfig1-dev \
  libfreetype6-dev \
  libjpeg8 \
  libmemcached-tools \
  libncursesw5-dev \
  libreadline-dev \
  libreadline6-dev \
  libsecret-1-0 \
  libsecret-1-dev \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  libvips \
  lsb-release \
  libvips-dev \
  mediainfo \
  memcached \
  mercurial \
  mmv \
  mosh \
  ncdu \
  nginx \
  npm \
  nodejs \
  perl \
  pkg-config \
  pandoc \
  poppler-utils \
  postgresql \
  python3 \
  python3-dev \
  python3-pip \
  python-pygments \
  rsync \
  sed \
  silversearcher-ag \
  tar \
  tmux \
  tree \
  unrar \
  vim \
  wget \
  xz-utils \
  zfsutils-linux

echo "cleaning up"
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
