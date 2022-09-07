#!/usr/bin/env bash

echo "updating dnf directories"
dnf check-update
dnf -y upgrade
dnf -y autoremove

echo "installing dependencies"
dnf -y install ansible \
  apt-transport-https \
  bash \
  build-essential \
  ca-certificates \
  certbot \
  clang \
  cmake \
  coreutils \
  curl \
  dnf-plugins-core \
  findutils \
  font-manager \
  fontconfig \
  gawk \
  gcc \
  gcc-c++ \
  ghc \
  gist \
  git \
  gnupg \
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
  poppler-utils \
  postgresql \
  python3 \
  python3-dev \
  python3-pip \
  python-pygments \
  readline \
  ripgrep \
  rsync \
  sed \
  silversearcher-ag \
  stow \
  tar \
  tmux \
  unrar \
  vim \
  virtualenv \
  wget \
  wireshark \
  xsel \
  xz-utils \
  zfsutils-linux \
  zsh

echo "cleaning up"
dnf clean all
