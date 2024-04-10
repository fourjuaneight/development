#!/usr/bin/env bash

echo "installing Golang Language Server"
/usr/local/go install github.com/nametake/golangci-lint-langserver@latest
/usr/local/go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.42.1
/usr/local/go install github.com/cweill/gotests/gotests
/usr/local/go install github.com/fatih/gomodifytags
/usr/local/go install github.com/josharian/impl
/usr/local/go install github.com/haya14busa/goplay/cmd/goplay
/usr/local/go install github.com/go-delve/delve/cmd/dlv
/usr/local/go install honnef.co/go/tools/cmd/staticcheck
/usr/local/go install golang.org/x/tools/gopls
/usr/local/go install github.com/erning/gorun@latest
