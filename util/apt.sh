#!/usr/bin/env bash

echo "updating apt-get directories"
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -f
apt-get autoremove -y

echo "installing dependencies"
apt-get install -y bash \
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
  gist \
  git \
  gnupg \
  golang-go \
  gpg \
  graphicsmagick \
  id3v2 \
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
  mc \
  mediainfo \
  memcached \
  mercurial \
  mkvtoolnix \
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
  stow \
  tar \
  tmux \
  tree \
  unrar \
  vim \
  virtualenv \
  wget \
  xz-utils \
  zfsutils-linux \
  zsh

echo "cleaning up"
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
