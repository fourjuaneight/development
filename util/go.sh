#!/usr/bin/env bash

echo 'export GOPATH=$HOME/go' >> .bashrc
echo 'export GOPATH=$HOME/go' >> .profile
echo 'export PATH=$PATH:$GOPATH/bin' >> .bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> .profile

echo "installing go binaries"
for pkg in $(bat -p go-packages.txt); do
  name=$(echo "$pkg" | sed 's/github\.com\///g')
  echo "$name";
  go install $pkg@latest
done
