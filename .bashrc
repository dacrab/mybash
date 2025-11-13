#!/usr/bin/env bash
# shellcheck disable=SC1091

# Only for interactive shells
[[ $- != *i* ]] && return

#################### INIT ####################

# System defaults and completion
[[ -f /etc/bashrc ]] && source /etc/bashrc
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

# Fast system info
command -v fastfetch >/dev/null 2>&1 && fastfetch

#################### SHELL OPTIONS ####################
shopt -s checkwinsize histappend
bind "set bell-style none" 2>/dev/null
bind "set completion-ignore-case on" 2>/dev/null
bind "set show-all-if-ambiguous on" 2>/dev/null
stty -ixon 2>/dev/null

#################### HISTORY ####################
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL="erasedups:ignoredups:ignorespace"
export PROMPT_COMMAND="history -a"

#################### ENV ####################
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export EDITOR="nvim"
export VISUAL="nvim"

export CLICOLOR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.composer/vendor/bin:$HOME/.config/herd-lite/bin:$HOME/.spicetify:$PATH"

# PHP
export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:${PHP_INI_SCAN_DIR:-}"

#################### FUNCTIONS ####################
get_distro() {
  if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    case "$ID" in
      fedora|rhel|centos|rocky|almalinux) echo "redhat" ;;
      ubuntu|debian|mint) echo "debian" ;;
      arch|manjaro|endeavouros) echo "arch" ;;
      opensuse*|sles) echo "suse" ;;
      gentoo) echo "gentoo" ;;
      *) echo "unknown" ;;
    esac
  else
    echo "unknown"
  fi
}

_list_dir() {
  if command -v eza >/dev/null 2>&1; then
    eza --icons --group-directories-first
  elif command -v exa >/dev/null 2>&1; then
    exa --icons --group-directories-first
  elif command -v lsd >/dev/null 2>&1; then
    lsd --group-dirs=first --icon=auto
  else
    ls -CF --color=auto
  fi
}

cd() {
  if [[ $# -eq 0 ]]; then
    if builtin cd ~; then _list_dir; fi
  else
    if builtin cd "$@"; then _list_dir; fi
  fi
}

extract() {
  for file in "$@"; do
    if [[ -f "$file" ]]; then
      case "$file" in
        *.tar.bz2) tar xjf "$file" ;;
        *.tar.gz)  tar xzf "$file" ;;
        *.tar.xz)  tar xJf "$file" ;;
        *.bz2)     bunzip2 "$file" ;;
        *.rar)     unrar x "$file" ;;
        *.gz)      gunzip "$file" ;;
        *.tar)     tar xf "$file" ;;
        *.tbz2)    tar xjf "$file" ;;
        *.tgz)     tar xzf "$file" ;;
        *.zip)     unzip "$file" ;;
        *.Z)       uncompress "$file" ;;
        *.7z)      7z x "$file" ;;
        *)         echo "Unknown archive format: $file" ;;
      esac
    else
      echo "File not found: $file"
    fi
  done
}

mkcd() { mkdir -p "$1" && cd "$1" || return; }

up() {
  local levels=${1:-1} path=""
  for ((i=0; i<levels; i++)); do path="../$path"; done
  cd "$path" || return
}

search_files() {
  if command -v rg >/dev/null 2>&1; then
    rg -n --color=always "$1" | less -R
  else
    grep -RIn --color=always "$1" . | less -R
  fi
}

myip() {
  echo "Internal IP:"
  ip route get 1.1.1.1 | awk '{print $7}' 2>/dev/null || echo "Not connected"
  echo "External IP:"
  curl -s ifconfig.me || echo "Unable to fetch"
}

gcom() { git add . && git commit -m "$1"; }
lazy() { git add . && git commit -m "$1" && git push; }
iplocal() { hostname -I | awk '{print $1}'; }

gclean() {
  git fetch -p
  git branch --merged | grep -E -v '(^\*|main|master|dev)' | xargs -r git branch -d
}

#################### ALIASES ####################

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

# System
alias c='clear'
alias h='history'
alias j='jobs -l'
alias path='echo -e "${PATH//:/\\n}"'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias reload='source ~/.bashrc'
alias please='sudo $(fc -ln -1)'
alias pathadd='export PATH="$PWD:$PATH" && echo "$PATH"'

# File ops
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'
command -v trash >/dev/null 2>&1 && alias rm='trash'

# Listing
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -a -1 --icons --group-directories-first'
  alias l='eza -1 --icons --group-directories-first'
  alias la='eza -a -1 --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first --no-user --no-group --no-permissions --no-filesize --time=modified --time-style="%Y-%m-%d %H:%M"'
  alias lt='eza -T --level=2 --icons --group-directories-first'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa -a -1 --icons --group-directories-first'
  alias l='exa -1 --icons --group-directories-first'
  alias la='exa -a -1 --icons --group-directories-first'
  alias ll='exa -l --icons --group-directories-first --no-user --no-group --no-permissions --no-filesize --time=modified --time-style="%Y-%m-%d %H:%M"'
  alias lt='exa -T --level=2 --icons --group-directories-first'
elif command -v lsd >/dev/null 2>&1; then
  alias ls='lsd -a -1 --group-dirs=first --icon=auto'
  alias l='lsd -1 --group-dirs=first --icon=auto'
  alias la='lsd -a -1 --group-dirs=first --icon=auto'
  alias ll='lsd -l --group-dirs=first --icon=auto --blocks date,name --date "+%Y-%m-%d %H:%M"'
  alias lt='lsd --tree --depth 2 --group-dirs=first --icon=auto'
else
  alias ls='ls --color=auto -F'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -1F'
  alias lt='ls -ltr'
fi
alias tree='tree -C'

# Text/IO
alias grep='grep --color=auto'
command -v bat >/dev/null 2>&1 && alias cat='bat'

# Archives
alias untar='tar -xvf'
alias targz='tar -czvf'

# Monitoring
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep'
command -v htop >/dev/null 2>&1 && alias top='htop'
if command -v netstat >/dev/null 2>&1; then
  alias ports='netstat -tulanp'
else
  command -v ss >/dev/null 2>&1 && alias ports='ss -tulpen'
fi

# Package mgmt
DISTRO=$(get_distro)
case "$DISTRO" in
  debian)
    alias install='sudo apt install'
    alias update='sudo apt update && sudo apt full-upgrade'
    alias search='apt search'
    alias remove='sudo apt remove'
    ;;
  redhat)
    alias install='sudo dnf install'
    alias update='sudo dnf upgrade --refresh'
    alias search='dnf search'
    alias remove='sudo dnf remove'
    ;;
  arch)
    alias install='sudo pacman -S'
    alias update='sudo pacman -Syu'
    alias search='pacman -Ss'
    alias remove='sudo pacman -R'
    ;;
esac

# Dev
alias vim='nvim'
alias vi='nvim'
alias edit='${EDITOR}'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias ggraph='git log --graph --decorate --oneline --all'
alias gst='git status -sb'
alias gco='git checkout'
alias gb='git branch --all'

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias di='docker images'
alias dclean='docker system prune -af'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcl='docker compose logs -f'

# Networking
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'
alias ippublic='curl -s https://ifconfig.me'

# Servers
alias serve='python3 -m http.server 8000'
alias servep='python3 -m http.server 8000 --bind 127.0.0.1'

# Custom
alias cursor-reset='cd ~/Documents/GitHub/cursor-reset && ./cursor-reset.sh'

#################### KEYBINDINGS ####################
bind '"\C-f":"zi\n"' 2>/dev/null

#################### PROMPT/ENHANCEMENTS ####################
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

#################### X11 ####################
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
  exec startx
fi

#################### EXTERNAL ####################
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"