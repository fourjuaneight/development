#!/usr/bin/env bash

echo 'export GOPATH=$HOME/go' >> .bashrc
echo 'export GOPATH=$HOME/go' >> .profile
echo 'export PATH=$PATH:$GOPATH/bin' >> .bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> .profile

echo "installing go binaries"
go install github.com/nektos/act@latest
go install github.com/junegunn/fzf@latest