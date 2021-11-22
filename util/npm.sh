#!/usr/bin/env bash

echo "updating Node modules install directory"
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo "installing global npm dependencies"
npm i -g @angular/cli\
  @angular/compiler-cli \
  @babel/cli \
  @capacitor/cli \
  @ionic/cli \
  @nestjs/cli \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  apollo \
  eslint \
  eslint-config-airbnb \
  eslint-config-prettier \
  eslint-plugin-html \
  eslint-plugin-import \
  eslint-plugin-jsx-a11y \
  eslint-plugin-prettier \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  fkill-cli \
  gatsby-cli \
  glyphhanger \
  husky \
  ionic \
  lint-staged \
  postcss \
  prettier \
  typescript \
  webpack-cli
