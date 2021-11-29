
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# ENV
source "${HOME}/.zshenv"

# GPG
export GPG_TTY=$(tty)

# Utils
eval "$(sheldon source)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Rust Cargo
source "$HOME/.cargo/env"

# Colors
if [[ $TERM == xterm ]]; then
  TERM=xterm-256color
fi

# Autosuggestions
[[ -f ~/.zsh/autosuggestions.zsh ]] && source ~/.zsh/autosuggestions.zsh

# fzf
[[ -f ~/.zsh/fzf.zsh ]] && source ~/.zsh/fzf.zsh

_fzf_compgen_path() {
  fd -HL -E ".git" . "$1"
}

# Aliases
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh

# Functions
[[ -f ~/.zsh/func.zsh ]] && source ~/.zsh/func.zsh
zmodload zsh/zprof

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

# fnm
export PATH=/home/fourjuaneight/.fnm:$PATH
eval "`fnm env`"
