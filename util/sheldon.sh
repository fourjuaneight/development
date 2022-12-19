#!/usr/bin/env bash

echo "installing zsh plugins via sheldon"
/home/node/.cargo/bin/sheldon --config-dir /home/node/.config/sheldon --data-dir /home/node/.config/sheldon lock
