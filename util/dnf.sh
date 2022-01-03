#!/usr/bin/env bash

echo "updating dnf directories"
dnf check-update
dnf -y upgrade
dnf -y autoremove

echo "installing dependencies"
dnf -y install bash \
  ca-certificates \
  certbot \
  clang \
  cmake \
  coreutils \
  curl \
  dnf-plugins-core \
  findutils \
  fontconfig-devel \
  freetype-devel \
  g++ \
  gawk \
  gcc \
  gcc-c++ \
  ghc \
  git \
  gnupg \
  golang \
  GraphicsMagick \
  id3v2 \
  ImageMagick \
  indent \
  inotify-tools \
  jasper \
  kernel-devel \
  libjpeg \
  libmemcached-awesome \
  libsecret \
  libxcb-devel \
  libxkbcommon-devel \
  mediainfo \
  memcached \
  mercurial \
  mkvtoolnix \
  mmv \
  mosh \
  ncdu \
  nginx \
  perl \
  pkgconf \
  pandoc \
  poppler \
  postgresql \
  python3 \
  python3-pip \
  python-pygments \
  readline \
  ripgrep \
  rsync \
  sed \
  stow \
  the_silver_searcher \
  tmux \
  vim \
  wget \
  xsel \
  xz \
  zsh

echo "cleaning up"
dnf clean all
