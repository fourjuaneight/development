#!/usr/bin/env bash

echo "updating dnf directories"
dnf check-update
dnf -y upgrade
dnf -y autoremove

action "adding zfs repo"
dnf install -y https://zfsonlinux.org/fedora/zfs-release$(rpm -E %dist).noarch.rpm

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
  fontconfig-devel \
  freetype-devel \
  g++ \
  gawk \
  gcc \
  gcc-c++ \
  ghc \
  gist \
  git \
  git-lfs \
  gnupg \
  golang \
  gpg \
  graphicsmagick \
  id3v2 \
  imagemagick \
  indent \
  indicator-multiload \
  inotify-tools \
  jasper \
  kernel-devel \
  libfontconfig1-dev \
  libfreetype6-dev \
  libjpeg8 \
  libmemcached-awesome \
  libmemcached-tools \
  libncursesw5-dev \
  libreadline-dev \
  libreadline6-dev \
  libsecret \
  libsecret-1-0 \
  libsecret-1-dev \
  libxcb-devel \
  libxcb-xfixes0-dev \
  libxkbcommon-dev \
  libxkbcommon-devel \
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
  pkgconf \
  pandoc \
  poppler \
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
  which \
  wireshark \
  xsel \
  xz \
  xz-utils \
  zfs \
  zfsutils-linux \
  zsh

echo "cleaning up"
dnf clean all
