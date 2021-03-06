# common cli commands
alias cd="z"
alias cdh="z ~"
alias ..="z .."
alias ...="z ../.."
alias ....="z ../../.."
alias .....="z ../../../.."
alias ......="z ../../../../.."
alias .......="z ../../../../../.."
alias ........="z ../../../../../../.."
alias .........="z ../../../../../../../.."
alias cl="clear"
alias dot="z ~/dotfiles"
alias unzip="xcompress x"

# alternative to 'cat'
alias cat="bat"

# alternative to 'find'
alias find="fd"

# alternatives to 'ls'
alias ls="exa"
alias ll="exa -l"
alias la="exa -a"

alias cls="ls -F | grep -v / | wc -l"

# alternative to 'tree'
alias tree="tree-rs"

# list files
alias lf="fd . -t f -E .DS_Store"
alias lfc="fd . -t f -E .DS_Store | wc -l"

# alternative to 'tree'
alias tree="tree-rs"

# search history
alias hgrep="history | ag"

# zsh
alias zconf="vim ~/.zshrc"
alias zsour="source ~/.zshrc"

# vim
alias vi="vim"
alias vconf="vim ~/.vimrc"
alias vsour="vim source ~/.vimrc"

# zellij
alias tmux="zellij"
alias zj="zellij"
alias zjconf="vim ~/.config/zellij/config.yaml"
alias zjdev="zellij --layout ~/.config/zellij/layout.dev.yaml"
alias zjgit="zellij --layout ~/.config/zellij/layout.git.yaml"

# ssh
alias rssh="sudo service ssh --full-restart"
alias stsh="sudo service ssh start"
alias spsh="sudo service ssh stop"

# Webpack
alias wpw="webpack -w"
alias wp="webpack"

# nvm
alias nvi="fnm install"
alias nvu="fnm use"
alias nviu="fnm install && fnm use --delete-prefix"
alias nr="npm run"
alias wnv="bat -p .nvmrc"

# Postgres
alias psl="psql postgres -h localhost -l"

# Git
# alias ga="git add"
alias gaa="git add --all"
alias gap="git add --patch"

alias gcm="git commit -S -m"
alias gc="git commit -S"

alias gf="git fetch"

alias gup="git push"

alias gp="git pull --rebase"
alias gsp="git stash && git pull --rebase && git stash pop"

alias gst="git status"
alias gstat="onefetch ."

alias gdf="git diff"
alias gdfn="git diff --name-only"
alias gdfs="git diff --staged"

alias grst="git reset"
alias grsth="git reset --hard"

alias gsta="git stash"
alias gstap="git stash pop"

alias gts="git tag -s"
alias gtv="git tag | sort -V"

alias ggc="git gc --aggressive --prune"
