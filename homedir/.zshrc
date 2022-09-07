# ENV
source "${HOME}/.zshenv"

# History
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# GPG
export GPG_TTY=$(tty)

# Utils
export EDITOR=hx
eval "$(sheldon source)"
eval "$(starship init zsh)"
zsh-defer eval "$(atuin init zsh)"
zsh-defer eval "$(zoxide init zsh)"
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
