#!/usr/bin/env bash

signingkey=$(git config --global --get user.signingkey)

if [[ ! -z $signingkey ]] && [[ ${#signingkey} == 16 ]]; then
    echo "Looks like your git signingkey is: $signingkey"
else
    echo "creating gpg key"
    running "using rsa 4096..."
    if [[ -z $(gpg --list-secret-keys) ]]; then
        gpg --full-generate-key
    fi
    gpg --list-secret-keys --keyid-format LONG
    read -p "Key |sec| rsa4096/*key* [SC]: " signingkey
    git config --global user.signingkey "$signingkey"
    gpg --armor --export $signingkey
    sed -i "s/signingkey\s=\s.*/signingkey = $signingkey/" ./homedir/.gitconfig
    echo "add the public key to your Github account."
fi

echo "creating config file"
cd ~
mkdir -p ~/.gnupg
touch ~/.gnupg/gpg-agent.conf

echo "pinentry-program /usr/bin/pinentry-curses" >> ~/.gnupg/gpg-agent.conf
echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf

gpgconf --kill gpg-agent

read -p "Did you add the key to GitHub? [y/n]: " added
if [[ $email == "y" ]]; then
    echo "testing config..."
    echo "Test" | gpg -as

    echo "gpg setup complete!"
else
    echo "make sure to add the key to your Github account."
fi