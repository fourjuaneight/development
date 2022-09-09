#!/usr/bin/env bash

echo "installing zsh plugins via sheldon"
/home/node/.cargo/bin/sheldon --config-dir /home/node/.config/sheldon --data-dir /home/node/.config/sheldon --clone-dir /home/node/.config/sheldon/repos --download-dir /home/node/.config/sheldon/downloads lock
