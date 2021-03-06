# UTILITIES #

# repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sd ' *[0-9]*\*? *' '' | sd '\\' '\\\\')
}

# find and kill process
fkp() {
  local pid
  pid=$(ps axco pid,command,time | sed 1d | fzf -m | mawk '{print $1}')

  if [[ "x$pid" != "x" ]];
  then
    echo $pid | xargs kill -${1:-9}
    fkp
  fi
}

# FONTS #

# glyphhanger whitelist Latin
gla() {
  local files fname
  IFS=$'\n' files=($(fzf --query="$1.ttf" --multi --select-1 --exit-0))
  fname="${files%.*}" &&
  if [[ -n "$files" ]]; then
    glyphhanger --LATIN --formats=woff2,woff --subset=$fname.ttf &&
    [[ -n "$fname-subset.woff" ]] && mv $fname-subset.woff $fname.woff &&
    [[ -n "$fname-subset.woff2" ]] && mv $fname-subset.woff2 $fname.woff2
  fi
}

# glyphhanger whitelist US ASCII
glu() {
  local files fname
  IFS=$'\n' files=($(fzf --query="$1.ttf" --multi --select-1 --exit-0))
  fname="${files%.*}" &&
  if [[ -n "$files" ]]; then
    glyphhanger --US_ASCII --formats=woff2,woff --subset=$fname.ttf
  fi
}

# IMAGES #

# converting PNG to WebP
png2webp() {
  fd -e png | xargs -P 8 -I {} sh -c 'cwebp -q 90 $1 -o "${1%.png}.webp"' _ {} \;
}

# converting JPEG to WebP
jpeg2webp() {
  fd -e jpg | xargs -P 8 -I {} sh -c 'cwebp -q 90 $1 -o "${1%.jpg}.webp"' _ {} \;
}

# converting HEIC to JPEG
heic2jpeg() {
  fd -e heic | xargs -P 8 -I {} sh -c 'magick mogrify -format jpg "$1"' _ {} \;
}

# converting PNG to JPEG
png2jpeg() {
  fd -e png | xargs -P 8 -I {} sh -c 'magick mogrify -format jpg "$1"' _ {} \;
}

# converting WebP to JPEG
webp2jpeg() {
  fd -e webp | xargs -P 8 -I {} sh -c 'magick mogrify -format jpg "$1"' _ {} \;
}

# FILES #

# find and extract archives
fex() {
  local files fname
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  fname="${files%.*}";

  if [ -n $files ] ; then
    case $files in
      *.tar.bz2)  tar -xvjf $file      ;;
      *.tar.gz)   tar -xvzf $file      ;;
      *.bz2)      bunzip2 -v $file     ;;
      *.rar)      unrar xv $file       ;;
      *.gz)       gunzip -v $file      ;;
      *.tar)      tar -xvf $file       ;;
      *.tbz2)     tar -xvjf $file      ;;
      *.tgz)      tar -xvzf $file      ;;
      *.zip)      unzip $file          ;;
      *.Z)        uncompress -v $file  ;;
      *.7z)       7z x $file -bb       ;;
      *)          echo "Don't know how to extract '$files'." ;;
    esac
  else
    echo "'$files' is not a valid file!"
  fi
}

# batch rename files with regex
brn() {
  local files filesMatch
  # remove quotes
  filesMatch=$(sd '^"(.*)"$' '$1' <<<$3)
  # convert to list
  IFS=$'\n' files=($(echo $filesMatch | ls))

  for file in $files; do
    new=$(echo "$file" | sd $1 $2) &&
    echo "$file -> $new"
    mv "$file" "$new"
  done
}

# select two files, but fold lines longer than 20 characters, then diff (via delta)
diffLongSel() {
  local file1 file2
  file1=$(fzf +m -q "$1") &&
  file2=$(fzf +m -q "$1") &&
  delta <(fold -s -w 20 $file1) <(fold -s -w 20 $file2)
}

# select two files, then diff (via delta)
diffSel() {
  local file1 file2
  file1=$(fzf +m -q "$1") &&
  file2=$(fzf +m -q "$1") &&
  delta $file1 $file2
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && code ${files[@]}
}

# using ripgrep combined with preview and open on VSCode
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  local file line
  file="$(rga --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rga --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rga --ignore-case --pretty --context 10 '$1' {}")" &&
  line=$(rg -n $1 $file | sd "^([0-9]+)\:\s\s.*" "$1") &&

  if [[ -n $file ]]
  then
    code -g $file:$line
  fi
}

# find and delete files
fdf() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && rm $files
}

# find and print files
fpf() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && echo $files
}

# DIRECTORIES #

# Open via rga with line number
fa() {
  local file
  local line

  read -r file line <<<"$(rga --no-heading -n $@ | fzf -0 -1 | mawk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
    code -g $file:$line
  fi
}

# find and show filepath
fsf() {
  local IFS files directory fullpath
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  directory=$(dirname $files)
  fullpath="$(pwd)/$directory"
  [[ -n "$files" ]] && open $fullpath
}

# find and open file (default app)
fof() {
  local files
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && open $files
}

# find and open file in VSCode
fofc() {
  local out file key
  IFS=$'\n' out=($(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [[ -n "$file" ]]; then
    [[ "$key" = ctrl-o ]] && code "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
cf() {
  local file

  file="$(locate -Ai -0 $@ | rga -z -v '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        z -- $file
     else
        z -- ${file:h}
     fi
  fi
}

# cd to selected directory
fcd() {
  local dir
  dir=$(fd -I -E node_modules -t d --prune . ./ 2> /dev/null | fzf +m) &&
  z "$dir"
}

# find file and move to another directory
ffmv() {
  local file dest
  IFS=$'\n' file=($(fzf --query="$1" --multi --select-1 --exit-0)) &&
  dest=$(fd -I -E node_modules -t f --prune . ./ */\.* 2> /dev/null | fzf +m) &&
  mv "$file" "$dest"
}

# cd to selected parent directory
fpcd() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --tac)
  z "$DIR"
}

# cd into the directory of the selected file
ffcd() {
   local file
   local dir
   file=$(fzf +m -q "$1") &&
   dir=$(dirname "$file") &&
   z "$dir"
}

# tree selected directory
ftr() {
  local dir
  dir=$(fd ${1:-.} -path '*/\.*' -prune \
                  -o -type d -not \( -name node_modules -prune \) -print 2> /dev/null | fzf +m) &&
  tree "$dir" -I node_modules
}

# find and delete directory
fdd() {
  local dir
  dir=$(fd -I -E node_modules -t d --prune . ./ 2> /dev/null | fzf +m) &&
  rm -rf $dir
}


# GIT #

# git log branch
glb() {
  git log --pretty=oneline --abbrev-commit origin/$1
}

# checkout git local branch
gcbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf -d 15 +m) &&
  git checkout $(echo "$branch" | sd ".* " "")
}

# checkout git remote branch
gcrbr() {
  git fetch
  local branches branch selectedBranch
  branches=$(git branch -r) &&
  selectedBranch=$(echo "$branches" | fzf +s +m -e) &&
  branch=$(echo "$selectedBranch" | sd '.*origin/([a-zA-Z0-9\.-_/]+)$' '$1')
  git checkout $branch
}

# create git branch and add to remote
gnbr() {
  git fetch
  git checkout -b $1
  git push -u
}

# delete git local branch
gdbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf -d 15 +m) &&
  git branch -D $(echo "$branch" | sd ".* " "")
}

# merge git local branch into current
gmbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf -d 15 +m) &&
  git merge -s ort $(echo "$branch" | sd ".* " "")
}

# merge squash git local branch into current
gmsbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf -d 15 +m) &&
  git merge -s ort --squash $(echo "$branch" | sd ".* " "")
}

# rebase git local branch into current
grebr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf -d 15 +m) &&
  git rebase $(echo "$branch" | sd ".* " "")
}

# git pull rebase given branch
gpr() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}

# git reset soft to commit id
grs() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --ansi --tac +s +m -e) &&
  git reset --soft $(echo "$commit" | sd ".* " "")
}

# git reset hard to commit id
grh() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --ansi --tac +s +m -e) &&
  git reset --hard $(echo "$commit" | sd ".* " "")
}

# git revert to commit
grvt() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --ansi --tac +s +m -e) &&
  git revert $(echo "$commit" | sd ".* " "")
}

# git commit browser
gscl() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (rga -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# find git commit and print selected message for new commit
fgcm() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%N%Creset %s' --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --ansi --tac +s +m -e | sd "^[a-z0-9]+\s-\s([a-zA-z\s]+).?" "$1") &&
  message="git commit -S -m \"$commit\""
  print -z $message
}

# edit commit
gec() {
  local commits commit id
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --ansi --tac +s +m -e) &&
  id=$(echo "$commit" | sd " .*" "")
  git rebase -i "$id^"
}

# GITHUB CLI #

# git create new PR, add title, select reviewer
gnpr() {
  git fetch
  local branches selectedBranch branch
  branches=$(git branch -r) &&
  selectedBranch=$(echo "$branches" | sd 'origin\/' '' | fzf --ansi +s +m -e) &&
  branch=$(echo $selectedBranch | sd '^\s*' '') &&
  gh pr create -B $branch -t $1
}

# git list PRs, then inspect
gvpr() {
  git fetch
  local selectedPR PR
  selectedPR=$(gh pr list | fzf --ansi --tac +s +m -e) &&
  PR=$(echo $selectedPR | sd '^([0-9]+).*' '$1') &&
  gh pr view $PR
}

# git merge PR. Provide number or select from open PRs
gmpr() {
  git fetch
  local selectedPR PR
  if [[ "$1" ]]; then
    gh pr merge $1 -s
  else
    selectedPR=$(gh pr list | fzf --ansi --tac +s +m -e) &&
    PR=$(echo $selectedPR | sd '^([0-9]+).*' '$1') &&
    gh pr merge $PR -s
  fi
}


# HOMEBREW #

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst=$(brew search ???$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]ackage
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}
