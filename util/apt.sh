#!/usr/bin/env bash

echo "updating apt-get directories"
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -f
apt-get autoremove -y

echo "installing dependencies"
apt-get install -y \
  apt-transport-https \
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
  gifsicle \
  gist \
  gnupg \
  golang-go \
  gpg \
  graphicsmagick \
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
  lsb-release \
  mariadb-server \
  mediainfo \
  memcached \
  mercurial \
  mysql-client \
  mysql-server \
  ncdu \
  nginx \
  nodejs \
  npm \
  optipng \
  pandoc \
  perl \
  pngquant \
  poppler-utils \
  postgresql \
  python-pygments \
  python3 \
  python3-dev \
  python3-pip \
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

apt install -y pkg-config libssl-dev

echo "cleaning up"
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*
