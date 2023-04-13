eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export PATH=$PATH:$HOME/.exo/bin

# Go
export PATH=$PATH:/usr/local/go/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"

# frum
eval "$(frum init)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Sheldon
export SHELDON_CONFIG_DIR="$HOME/.config/sheldon"
export SHELDON_DATA_DIR="$SHELDON_CONFIG_DIR"
export SHELDON_CONFIG_FILE="$SHELDON_CONFIG_DIR/plugins.toml"
export SHELDON_LOCK_FILE="$SHELDON_CONFIG_DIR/plugins.lock"
export SHELDON_CLONE_DIR="$SHELDON_DATA_DIR/repos"
export SHELDON_DOWNLOAD_DIR="$SHELDON_DATA_DIR/downloads"

# Starship
export STARSHIP_CONFIG=~/.config/starship/config.toml

# fzf
export FZF_DEFAULT_COMMAND="rga --files --no-ignore-vcs --hidden --follow --glob '!.git/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zellij
export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

# SKIM
export SKIM_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD || rg --files || fd ."
