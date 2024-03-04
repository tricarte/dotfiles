#!/usr/bin/env bash
# Function Extract for common file formats
# https://github.com/xvoland/Extract/blob/master/extract.sh

# Use "unpack" instead.
SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function extract() {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"; do
      if [ -f "$n" ]; then
        case "${n%,}" in
        *.cbt | *.tar.bz2 | *.tar.gz | *.tar.xz | *.tbz2 | *.tgz | *.txz | *.tar)
          tar xvf "$n"
          ;;
        *.lzma) unlzma ./"$n" ;;
        *.bz2) bunzip2 ./"$n" ;;
        *.cbr | *.rar) unrar x -ad ./"$n" ;;
        *.gz) gunzip ./"$n" ;;
        *.cbz | *.epub | *.zip) unzip ./"$n" ;;
        *.z) uncompress ./"$n" ;;
        *.7z | *.apk | *.arj | *.cab | *.cb7 | *.chm | *.deb | *.dmg | *.iso | *.lzh | *.msi | *.pkg | *.rpm | *.udf | *.wim | *.xar)
          7z x ./"$n"
          ;;
        *.xz) unxz ./"$n" ;;
        *.exe) cabextract ./"$n" ;;
        *.cpio) cpio -id <./"$n" ;;
        *.cba | *.ace) unace x ./"$n" ;;
        *.zpaq) zpaq x ./"$n" ;;
        *.arc) arc e ./"$n" ;;
        *.cso) ciso 0 ./"$n" ./"$n.iso" &&
          extract "${n}.iso" && \rm -f "$n" ;;
        *)
          echo "extract: '$n' - unknown archive method"
          return 1
          ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
  fi
}
export -f extract

IFS=$SAVEIFS

# Just reload the profile (mnemonic BashSource or BullS*)
bs() { echo "Sourcing .bashrc" && . "${HOME}/.bashrc"; }
export -f bs

# Grep history
function h() {
  history | grep "$1"
}

# Make directory and cd into it
mkcd() {
  mkdir "$@"
  cd "$@" || exit
}

# Start tmux
tm() {
  # TMUX=$(command -v tmux)
  # $TMUX has-session -t mytmux > /dev/null 2>&1
  # if [ $? == 0 ]; then
  #     tmux a -t mytmux
  # else
  #     tmux
  # fi
  tmuxp load mytmux -y
  # exit
}

# Using lf's custom function: paths
# Copy filename into bucket
# function fb() {
#   if ! [[ -f "$1" ]]; then
#     $1 | bucket
#   else
#     file=$(readlink -f "$1")
#     bucket "$file"
#   fi
# }
# export -f fb

# Go up one directory in file system.
up() {
  for ((i = 1; i <= ${1:-1}; i++)); do
    cd ..
  done
}

# VirtualBox Management
startvm() {
  # start a VM as headless, no need for a GUI
  __davms "startvm" "--type headless"
}

stopvm() {
  # allow stopping a VM by saving its state or simply turning it off
  action="savestate"
  if [ "$1" == "--poweroff" ]; then
    action="poweroff"
  fi
  __davms "controlvm" $action
}

showvms() {
  # show all of the VMs including those that are running
  echo "All VMs:"
  VBoxManage list vms
  echo ""
  echo "Runnings VMs:"
  VBoxManage list runningvms
}

__davms() {
  cmd="VBoxManage $1"
  # some commands require parameters AFTER the vmname is specified
  cmd_suffix="$2"
  case "$1" in
  "controlvm")
    davms=$(VBoxManage list runningvms | sed 's/\"\ {/\"-{/' | grep ^\" | sed 's/\"//g')
    matches=$(echo "$davms" | gawk -F '}' '{print NF}')
    ;;
  "startvm")
    davms=$(VBoxManage list vms | sed 's/\"\ {/\"-{/' | grep ^\" | sed 's/\"//g')
    matches=$(echo "$davms" | gawk -F '}' '{print NF}')
    ;;
  esac

  case "$matches" in
  0)
    echo "No vms found"
    show=""
    ;;
  *)
    echo
    echo "Multiple matches found..."
    i=1
    for option in $davms; do
      echo "$i: $option" | sed 's/-{/\ {/'
      i=$(expr $i + 1)
    done
    echo "q: Quit"
    echo
    read -p "? " ans
    if [ "q" == "$ans" ]; then
      show=""
    else
      show=$(echo $davms | gawk '{print $'$ans'}' | sed 's/-{/\ /' | gawk '{print $1}')
    fi
    ;;
  esac

  if [ "" != "$show" ]; then
    $cmd $show $cmd_suffix
    # echo $cmd $show $cmd_suffix
  fi

}

# man() {
#   env \
#     LESS_TERMCAP_mb=$'\e[01;31m' \
#     LESS_TERMCAP_md=$'\e[01;31m' \
#     LESS_TERMCAP_me=$'\e[0m' \
#     LESS_TERMCAP_se=$'\e[0m' \
#     LESS_TERMCAP_so=$'\e[01;44;33m' \
#     LESS_TERMCAP_ue=$'\e[0m' \
#     LESS_TERMCAP_us=$'\e[01;32m' \
#     man "$@"
# }

# Use pager in ls output
lsp() { ls -ah --color=always "$@" | less -R -X -F; }

# Function for always using one (and only one) vim server, even when not
# using gvim.
# If you really want a new vim session, simply do not pass any
# argument to this function.
# http://vim.wikia.com/wiki/Enable_servername_capability_in_vim/xterm
function vim() {
  vim_orig=$(which 2>/dev/null vim)
  if [ -z "$vim_orig" ]; then
    echo "$SHELL: vim: command not found"
    return 127
  fi
  # $vim_orig --serverlist | grep -q VIM

  # If there is already a vimserver, use it
  # unless no args were given
  # if [ $? -eq 0 ]; then
  if $vim_orig --serverlist | grep -q VIM; then
    if [ $# -eq 0 ]; then
      $vim_orig
    else
      $vim_orig --remote-silent "$@"
    fi
  else
    $vim_orig --servername vim "$@"
  fi
}
export -f vim

# https://github.com/ranger/ranger/blob/master/examples/bash_automatic_cd.sh
function ranger-cd() {
  tempfile="$(mktemp -t tmp.XXXXXX)"
  /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  # /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
      cd -- "$(cat "$tempfile")" || return
    fi
  /bin/rm -f -- "$tempfile"
}
# https://wiki.archlinux.org/index.php/Ranger#Shell_tips
rgr() {
  if [ -z "$RANGER_LEVEL" ]; then
    ranger-cd "$@"
  else
    exit
  fi
}
bind '"\C-b":"rgr\C-m"'

# Cd into wp sites under ~/sites easily with ranger-cd
# 'wpr last' can cd into the last created site.
# completion function is in .bashrc_custom
wpr() {
  SITE=$1

  if [[ -z $SITE ]]; then
    echo "Provide a directory name that is inside ~/sites."
    return
  fi

  if [[ $SITE == "last" ]]; then
    LAST=$(findLastSite)

    # ranger-cd "$HOME/sites/$LAST"
    if [[ -d "$HOME/sites/$LAST" ]]; then
      lfc "$HOME/sites/$LAST"
    else
      echo "No wpstarter based site was found."
      return 1
    fi

    return
  fi

  if [[ -d "$HOME/sites/$SITE" ]]; then
    # ranger-cd "$HOME/sites/$1"
    lfc "$HOME/sites/$1"
    return
  else
    echo "$HOME/sites/$SITE does not exist."
    return 1
  fi
}

# https://www.linuxjournal.com/content/developing-console-applications-bash
# generate base64 encoded basicauth header string for http clients
basicauth() {
  if [ -z "$1" ]; then
    echo "Usage: basicauth <username>"
  else
    echo "$1:$(
      read -r -s -p "Enter password: " pass
      echo "$pass"
    )" | openssl enc -base64
  fi
}
export -f basicauth

# Remove duplicate entries from $PATH when in inside TMUX
pathmunge() {
  if ! echo "$PATH" | /usr/bin/grep -qE "(^|:)$1($|:)"; then
    if [ "$2" = "after" ]; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

# Copy file content over SSH
# cpssh SSHHOSTNAME /path/to/remote/file
cpssh() {
  ssh "$1" "cat $2" | xclip -selection c
}
export -f cpssh

# Copy content that is stored by VIM with :Clipboard command
# cpsshvim SSHHOSTNAME
cpsshvim() {
  ssh "$1" "cat ~/.clipboard" | xclip -selection c
}
export -f cpsshvim

# Clone ~/repos/pws to ~/sites/$RANDOM
# and start serving using PHP's builtin server
pwsnew() {
  if [[ ! -d "$HOME/repos/pws" ]]; then
    echo "Err: Source repository does not exist."
    return 1
  fi

  if [[ ! -d "$HOME/sites" ]]; then
    mkdir "$HOME/sites"
  fi

  DOCROOT="$HOME/sites/pws-$RANDOM"

  git clone --quiet "$HOME/repos/pws" "$DOCROOT"

  echo "Site root is at: $DOCROOT"
  echo ""

  "$DOCROOT/pws" "$DOCROOT"
  # xdg-open "http://localhost:8080"
}

# Serve current directory using PHP's builtin server.
pws() {
  # If this is a pws repository, then serve using the existing script.
  if [[ -x "./pws" ]]; then
    ./pws
    return
  fi

  PWSREPO="$HOME/repos/pws"

  if [[ ! -d "$PWSREPO" ]]; then
    echo "Err: Source repository does not exist."
    return 1
  fi

  DOCROOT="$PWD"

  echo "Serving from: $DOCROOT"
  echo ""

  PHP=$(command -v php)
  COMMAND="$PHP -S localhost:8080 -t $DOCROOT -c $PWSREPO/php.ini"

  if [[ -f "$DOCROOT/php.ini" ]]; then
    COMMAND="${COMMAND} ${DOCROOT}/php.ini"
  fi

  if [[ -f "$PWD/router.php" ]]; then
    COMMAND+=" $PWD/router.php"
  fi

  $COMMAND
  # xdg-open "http://localhost:8080"
}

# Below two fzf_* functions allows using <C-a>
# as a way to list and choose from your bash aliases.
fzf_alias_select() {
  local cmd opts
  cmd="command grep -E ^alias ~/.bash_aliases | cut -d' ' -f2-"
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS -m"
  eval "$cmd" | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) "$@" | while read -r item; do
    item=$(cut -d'=' -f1 < <(echo "$item"))
    printf '%s' "$item"
  done
}

fzf_alias_widget() {
  local selected
  selected="$(fzf_alias_select "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$((READLINE_POINT + ${#selected}))
}
bind -x '"\C-a":"fzf_alias_widget"'

# Run tests using phpunit
t() {
  if [ -f vendor/bin/phpunit ]; then
    vendor/bin/phpunit "$@"
  else
    phpunit "$@"
  fi
}

# Alternative to `~/bin/fuz`
# ctrl+o opens selection with xdg-open
fo() {
  local IFS=$'\n'
  local out=()
  local key
  local file

  out=(
    "$(
      fzf-tmux \
        --query="$1" \
        --exit-0 \
        --expect=ctrl-o,ctrl-e
    )"
  )
  key="$(head -1 <<<"${out[@]}")"
  file="$(head -2 <<<"${out[@]}" | tail -1)" || return

  if [[ "$key" == ctrl-o ]]; then
    "${OPENER:-xdg-open}" "$file"
  else
    "${EDITOR:-vim --remote-silent}" "$file"
  fi
}
export -f fo

# fkill - kill process
fkill() {
  local pid

  pid="$(
    ps -ef |
      sed 1d |
      fzf -m |
      awk '{print $2}'
  )" || return

  kill -"${1:-9}" "$pid"
}
export -f fkill

# Just like rgr, but for nnn
n() {
  # Block nesting of nnn in subshells
  if [[ "${NNNLVL:-0}" -ge 1 ]]; then
    echo "nnn is already running"
    return
  fi

  # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
  # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
  # see. To cd on quit only on ^G, remove the "export" and make sure not to
  # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
  #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  # The backslash allows one to alias n to nnn if desired without making an
  # infinitely recursive alias
  # \nnn "$@"
  "$HOME/repos/nnn/nnn"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# Just like rgr, but for lf as directory picker
lfc() {
  tmp="$(mktemp)"
  lf -command 'set nopreview' -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir" || return
      fi
    fi
  fi
}

# Create encrypted secrets file
# Just run enc, then give a filename with extension.
enc() {
  read -rp "Name of the encrypted output file: " name
  if [[ -n $name ]]; then
    echo -e "Now type the content, press the Enter key and then Ctrl+D to exit.\n"
    gpg --output "$name" --symmetric -
    if [[ -f "$name" ]]; then
      echo "Encrypted file successfully created."
      return
    fi
  else
    echo "You have to name the encryted file."
    return 1
  fi
}
export -f enc

# https://github.com/beauwilliams/awesome-fzf
# Man without options will use fzf to select a page
function fman() {
  MAN=$(command -v man)
  if [ -n "$1" ]; then
    $MAN "$@"
    return $?
  else
    $MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
    return $?
  fi
}

# Fuzzy search environment variables
function fenv() {
  local out
  out=$(env | fzf)
  echo "${out}" | cut -d= -f2
}

# reinit a git repository:
# Commit a last one and merge all previous commits
# except the first one into a single commit.
function grinit() {
  printf "Enter commit msg: "
  read -r msg

  if [[ $1 == 'd' ]]; then
    GIT="dfiles"
  else
    GIT=$(command -v git)
  fi

  count=$($GIT rev-list HEAD --count)
  count=$((count-1))
  $GIT reset --soft HEAD~${count}
  $GIT commit -m"${msg}"
}

# Deprecated
# Use fman instead since perl documentation can be reached with man.
# function pd() {
#     perldoc "perl${1}"
# }

# rcsync backup-directory-name
# Sync two rustic repositories on different external storages.
# TODO: Storages are hardcoded.
function rcsync() {
    RCLONE=$(command -v rclone)
    dir="${1}"
    user=$(getent passwd 1000 | cut -d':' -f1)
    src="/media/${user}/D892E34792E32928/rustic-backups/${dir}/"
    target="/media/${user}/sandisk32/rustic-backups/${dir}/"

    if [[ ! -d "${src}" ]]; then
        echo "${src} is not reachable."
        return 1
    fi

    if [[ ! -d "${target}" ]]; then
        echo "${target} is not reachable."
        return 1
    fi

    $RCLONE sync --progress "${src}" "${target}"
}

# Check perl module is installed
# pmodi Devel::REPL
function pmodi() {
    MOD="${1}"
    perl -M"$MOD" -e 'exit;' && echo "Module is available!" || echo "Module is not available!"
}

# cl 8080 -> curl 127.0.0.1:8080
# cl 8080/login -> curl 127.0.0.1:8080/login
# cl example.com -> curl example.com
function cl() {
    CURL_CMD="$(command -v curl) --silent --include"
    PAGER=$(command -v bat)
    if [[ -z $PAGER ]]; then
        PAGER="$(command -v less)"
    fi
    address="${1}"
    if [[ -f './.curl' ]]; then
        curl_file=$(cat ./.curl)
        address="${curl_file}${address}"
        ${CURL_CMD} "${address}" | $PAGER
        return
    fi

    if [[ -z "${address}" ]]; then
        echo "Curl to a port on localhost or to a specific domain directly."
        echo "Or you can create a file named '.curl' in project root"
        echo "in which you can define the host:port combo like this: 127.0.0.1:8080/"
        echo ""
        echo "Usage:"
        echo "  cl 8080        -> 'curl 127.0.0.1:8080'"
        echo "  cl example.com -> 'curl example.com'"
        echo ""
        echo "  # Or inside directory with a '.curl' file with 'host:port/' inside:"
        echo "  cl route       -> 'curl host:port/route'"
        return
    fi

    if [[ ! "$address" =~ ^[[:digit:]] ]]; then
        echo "${address}"
        ${CURL_CMD} "${address}" | $PAGER
        return
    else
        echo "${address}"
        ${CURL_CMD} "127.0.0.1:${address}" | $PAGER
        return
    fi
}

# Search for PHP extensions in available and active ones
# Usage: phpm exif
function phpm() {
    package="${1}"
    php -m | grep "${package}"
}

# Total memory usage of process by process name case-insensitively
# Requires ps_mem script and pgrep
# Usage: memo firefox
#      : memo -t firefox
function memo() {
    if [[ $# == 0 ]]; then
        echo "Usage: memo [-t] firefox"
        return 1
    fi

    if [[ $# == 2 ]]; then
        if [[ $1 != '-t' ]]; then
            echo "Usage: memo [-t] firefox"
            return 1
        fi

        numfmt --to=iec --suffix=B --format="%.3f" \
            "$(ps_mem -t -p "$(pgrep -i --full "${2}" -d,)")"
        return
    fi

    if [[ $# == 1 ]]; then
        process="${1}"
        ps_mem -d -S -p "$(pgrep -i --full "${process}" -d,)"
    fi

}
