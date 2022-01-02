#!/usr/bin/env bash

echo "updating dnf directories"
dnf check-update
dnf -y upgrade
dnf -y autoremove

echo "adding zfs repo"
dnf install -y https://zfsonlinux.org/fedora/zfs-release$(rpm -E %dist).noarch.rpm

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
  font-manager \
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
  graphicsmagick \
  id3v2 \
  imagemagick \
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
  zfs \
  zsh
  
echo "installing alacritty"
dnf -y install rust-alacritty

echo "loading zfs kernel module"
modprobe zfs

echo "cleaning up"
dnf clean all
