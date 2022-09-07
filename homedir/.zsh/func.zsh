# UTILITIES #

# repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sk --no-sort --tac | sd ' *[0-9]*\*? *' '' | sd '\\' '\\\\')
}

# find and kill process
fkp() {
  local pid
  pid=$(ps axco pid,command,time | sed 1d | sk --multi | mawk '{print $1}')

  if [[ "x$pid" != "x" ]]; then
    echo $pid | xargs kill -${1:-9}
    fkp
  fi
}

# FONTS #

# glyphhanger whitelist Latin
gla() {
  local file fname
  IFS=$'\n' file=($(gum choose --no-limit))
  fname="${file%.*}" &&
    if [[ -n "$file" ]]; then
      glyphhanger --LATIN --formats=woff2,woff --subset=$file &&
      [[ -n "$fname-subset.woff" ]] && mv $fname-subset.woff $fname.woff &&
      [[ -n "$fname-subset.woff2" ]] && mv $fname-subset.woff2 $fname.woff2
    fi
}

agla() {
  for file in $(ls *.*tf); do
    fname="${file%.*}"
    glyphhanger --LATIN --formats=woff2,woff --subset=$file &&
    [[ -n "$fname-subset.woff" ]] && mv $fname-subset.woff $fname.woff &&
    [[ -n "$fname-subset.woff2" ]] && mv $fname-subset.woff2 $fname.woff2
  done
}

# glyphhanger whitelist US ASCII
glu() {
  local file fname
  IFS=$'\n' file=($(gum choose --no-limit))
  fname="${file%.*}" &&
    if [[ -n "$file" ]]; then
      glyphhanger --US_ASCII --formats=woff2,woff --subset=$file
    fi
}

aglu() {
  for file in $(ls *.*tf); do
    glyphhanger --US_ASCII --formats=woff2,woff --subset=$file
  done
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

# render markdown files
rmd() {
  inlyne $1 --theme dark
}

# find and extract archives
fex() {
  local file fname
  IFS=$'\n' file=($(sk --query "$1" --select-1 --exit-0))
  fname="${file%.*}"

  if [ -n $file ]; then
    case $file in
    *.tar.bz2) tar -xvjf $file ;;
    *.tar.gz) tar -xvzf $file ;;
    *.bz2) bunzip2 -v $file ;;
    *.rar) unrar xv $file ;;
    *.gz) gunzip -v $file ;;
    *.tar) tar -xvf $file ;;
    *.tbz2) tar -xvjf $file ;;
    *.tgz) tar -xvzf $file ;;
    *.zip) unzip $file ;;
    *.Z) uncompress -v $file ;;
    *.7z) 7z x $file -bb ;;
    *) echo "Don't know how to extract '$file'." ;;
    esac
  else
    echo "'$file' is not a valid file!"
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
  file1=$(sk --query "$1") &&
    file2=$(sk --query "$1") &&
    delta <(fold -s -w 20 $file1) <(fold -s -w 20 $file2)
}

# select two files, then diff (via delta)
diffSel() {
  local file1 file2
  file1=$(sk --query "$1") &&
    file2=$(sk --query "$1") &&
    delta $file1 $file2
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(sk --query "$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && hx ${files[@]}
}

# using ripgrep combined with preview and open on editor
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  local file line
  file="$(rg --files-with-matches --no-messages "$1" | sk --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}")" &&
    line=$(rg -n $1 $file | sed -E 's/^([0-9]+).*/\1/') &&
    if [[ -n $file ]]; then
      hx $file:$line
    fi
}

# find and delete files
fdf() {
  local files
  IFS=$'\n' files=($(sk --query "$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && rm $files
}

# find and print files
fpf() {
  local files
  IFS=$'\n' files=($(sk --query "$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && echo $files
}

# DIRECTORIES #

# Open via rg with line number
fa() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading -n $@ | sk --exit-0 --select-1 | mawk -F: '{print $1, $2}')"

  if [[ -n $file ]]; then
    hx $file:$line
  fi
}

# find and show filepath
fsf() {
  local IFS files directory fullpath
  IFS=$'\n' files=($(sk --query "$1" --multi --select-1 --exit-0))
  directory=$(dirname $files)
  fullpath="$(pwd)/$directory"
  [[ -n "$files" ]] && open $fullpath
}

# find and open file (default app)
fof() {
  local files
  IFS=$'\n' files=($(sk --query "$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && open $files
}

# fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
cf() {
  local file

  file="$(locate -Ai -0 $@ | rg -z -v '~$' | sk --read0 --exit-0 --select-1)"

  if [[ -n $file ]]; then
    if [[ -d $file ]]; then
      z -- $file
    else
      z -- ${file:h}
    fi
  fi
}

# cd to selected directory
fcd() {
  local dir
  dir=$(fd -I -E node_modules -t d --prune . ./ 2>/dev/null | sk) &&
    z "$dir"
}

# cd to repo directory and open in vscode
fcdr() {
  local dir
  dir=$(fd -I -E node_modules -t d --prune . ~/Repos 2>/dev/null | sk) &&
  z "$dir" &&
  fnm use;
  clear &&
  code "$dir"
}

# find file and move to another directory
ffmv() {
  local file dest
  IFS=$'\n' file=($(sk --query "$1" --multi --select-1 --exit-0)) &&
    dest=$(fd -I -E node_modules -t f --prune . ./ */\.* 2>/dev/null | sk) &&
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
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | sk --tac)
  z "$DIR"
}

# cd into the directory of the selected file
ffcd() {
  local file
  local dir
  file=$(sk --query "$1") &&
    dir=$(dirname "$file") &&
    z "$dir"
}

# tree selected directory
ftr() {
  local dir
  dir=$(fd ${1:-.} -path '*/\.*' -prune \
    -o -type d -not \( -name node_modules -prune \) -print 2>/dev/null | sk) &&
    tree "$dir" -I node_modules
}

# find and delete directory
fdd() {
  local dir
  dir=$(fd -I -E node_modules -t d --prune . ./ 2>/dev/null | sk) &&
    rm -rf $dir
}

# GIT #

# run command on multiple repos
mg() {
  local selections
  selections=$(fd -I -E node_modules -t d --prune . ~/Repos 2>/dev/null | sk --multi) &&

  echo "$selections" | while IFS= read -r repo; do
    echo "Running on $repo:" &&
    pushd && z "$repo" && eval "$1" && popd;
  done
}

# git log branch
glb() {
  git log --pretty=oneline --abbrev-commit origin/$1
}

# checkout git local branch
gcbr() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | sk --delimiter 15) &&
    git checkout $(echo "$branch" | sd ".* " "") &&
    git pull --rebase
}

# checkout git remote branch
gcrbr() {
  git fetch
  local branches branch selectedBranch
  branches=$(git branch -r) &&
    selectedBranch=$(echo "$branches" | sk --no-sort --exact) &&
    branch=$(echo "$selectedBranch" | sd '.*origin/([a-zA-Z0-9\.-_/]+)$' '$1')
  git checkout $branch &&
  git pull --rebase
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
    branch=$(echo "$branches" | sk --delimiter 15) &&
    git branch -D $(echo "$branch" | sd ".* " "")
}

# merge git local branch into current
gmbr() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | sk --delimiter 15) &&
    git merge -s ort $(echo "$branch" | sd ".* " "")
}

# merge squash git local branch into current
gmsbr() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | sk --delimiter 15) &&
    git merge -s ort --squash $(echo "$branch" | sd ".* " "")
}

# rebase git local branch into current
grebr() {
  local branches branch
  branches=$(git branch) &&
    branch=$(echo "$branches" | sk --delimiter 15) &&
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
    commit=$(echo "$commits" | sk --ansi --tac --no-sort --exact) &&
    git reset --soft $(echo "$commit" | sd ".* " "")
}

# git revert to commit
grvt() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | sk --ansi --tac --no-sort --exact) &&
    git revert $(echo "$commit" | sd ".* " "")
}

# git commit browser
gscl() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    sk --ansi --no-sort --reverse --tiebreak index --bind ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (rg -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# find git commit and print selected message for new commit
fgcm() {
  local commits commit
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%N%Creset %s' --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | sk --ansi --tac --no-sort --exact | sd "^[a-z0-9]+\s-\s([a-zA-z\s]+).?" "$1") &&
    message="git commit -S -m \"$commit\""
  print -z $message
}

# edit commit
gec() {
  local commits commit id
  commits=$(git log --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | sk --ansi --tac --no-sort --exact) &&
    id=$(echo "$commit" | sd " .*" "")
  git rebase -i "$id^"
}

# GITHUB CLI #

# git create new PR, add title, select reviewer
gnpr() {
  local branches selectedBranch branch reviewers handle
  users=("fourjuaneight" "davidbbaxter" "baileysh9" "bbohach")
  git fetch &&
    branches=$(git branch -r) &&
    selectedBranch=$(echo "$branches" | sd 'origin/HEAD -> .*\n' '' | sd 'origin/' '' | sk --ansi --no-sort --exact) &&
    branch=$(echo $selectedBranch | sd '^\s*' '') &&
    handle=$(printf "%s\n" "${users[@]}" | sk --ansi --tac --no-sort --exact) &&
    gh pr create -B $branch -t $1 -r $handle
}

# git list PRs, then inspect
gvpr() {
  git fetch
  local selectedPR PR
  selectedPR=$(gh pr list | sk --ansi --tac --no-sort --exact) &&
    PR=$(echo $selectedPR | sd '^([0-9]+).*' '$1') &&
    gh pr view $PR
}

# git merge (squash and delete branch) PR. Provide number or select from open PRs
gmpr() {
  git fetch
  local selectedPR PR
  if [[ "$1" ]]; then
    gh pr merge $1 -s
  else
    selectedPR=$(gh pr list | sk --ansi --tac --no-sort --exact) &&
      PR=$(echo $selectedPR | sd '^([0-9]+).*' '$1') &&
      gh pr merge $PR -s -d
  fi
}

# NPM #

fnr() {
  local scripts
  script="$(jq -r '.scripts | keys | .[]' package.json | gum filter)"
  npm run $script
}

# Version key/value should be on his own line
npv() {
  local pkg_version
  pkg_version=$(cat package.json \
    | grep version \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g')

  echo $pkg_version
}


# DOCKER #

# delete all containers and images
dckclean() {
  local dangling
  docker system df &&
    docker system prune -a -f &&
    dangling=$(docker volume ls -qf dangling=true)
  if [[ "$dangling" ]]; then
    docker volume rm "$dangling"
  fi
}

# find and delete docker images
dckrmim() {
  local images selectedImage image imageList
  images=$(docker image list --format "table {{.ID}}\t{{.Repository}}" | sed -n '1!p') &&
    # use <TAB> to select multiple items
    selectedImage=$(echo "$images" | gum filter) &&
    image=$(echo $selectedImage | sd '^([a-z0-9]+)\s+.*' '$1') &&
    # converte list to space separate string
    imageList=$(echo $image | mawk 'FNR!=1{print l}{l=$0};END{ORS="";print l}' ORS=' ') &&
    docker image rm $imageList
}

# find and delete docker containers
dckrmcn() {
  local containers selectedContainer container containerList
  containers=$(docker container list --format "table {{.ID}}\t{{.Repository}}" | sed -n '1!p') &&
    # use <TAB> to select multiple items
    selectedContainer=$(echo "$containers" | gum filter) &&
    container=$(echo $selectedContainer | sd '^([a-z0-9]+)\s+.*' '$1') &&
    # converte list to space separate string
    containerList=$(echo $container | mawk 'FNR!=1{print l}{l=$0};END{ORS="";print l}' ORS=' ') &&
    docker container rm $containerList
}

# find and start docker services
dckup() {
  local services selectedService
  services=$(docker-compose ps --services) &&
    selectedService=$(echo "$services" | gum filter) &&
    clear && docker compose up $selectedService
}
