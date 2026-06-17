#!/usr/bin/env bash
# shellcheck disable=SC1091

# Only for interactive shells
[[ $- != *i* ]] && return

#################### SYSTEM DEFAULTS ####################

# Source system bashrc and completion
[[ -f /etc/bashrc ]] && source /etc/bashrc
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

# Fast system info on startup
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
PROMPT_COMMAND="history -a"

#################### XDG BASE DIRECTORIES ####################

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

#################### EDITOR & PAGER ####################

export EDITOR="nvim"
export VISUAL="nvim"

# Colored man pages with bat
if command -v bat >/dev/null 2>&1; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Less colors
export CLICOLOR=1
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

#################### PATH ####################

export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.composer/vendor/bin" ]] && export PATH="$HOME/.composer/vendor/bin:$PATH"
[[ -d "$HOME/.config/herd-lite/bin" ]] && export PATH="$HOME/.config/herd-lite/bin:$PATH"
[[ -d "$HOME/.spicetify" ]] && export PATH="$HOME/.spicetify:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

#################### LANGUAGE & RUNTIME ENVIRONMENTS ####################

# Bun
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"

# Java
if [[ -d /usr/lib/jvm/java-25-openjdk ]]; then
  export JAVA_HOME=/usr/lib/jvm/java-25-openjdk
elif [[ -d /usr/lib/jvm/java-25-openjdk-amd64 ]]; then
  export JAVA_HOME=/usr/lib/jvm/java-25-openjdk-amd64
fi
[[ -n "${JAVA_HOME:-}" ]] && export PATH="$JAVA_HOME/bin:$PATH"

# PHP
[[ -d "$HOME/.config/herd-lite/bin" ]] && export PHP_INI_SCAN_DIR="$HOME/.config/herd-lite/bin:${PHP_INI_SCAN_DIR:-}"

#################### TOOL CONFIGURATIONS ####################

# Starship prompt
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# FZF
if [[ -f "$HOME/.fzf.bash" ]]; then
    source "$HOME/.fzf.bash"
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Clipboard (Wayland/X11)
if command -v wl-copy >/dev/null 2>&1; then
    alias copy='wl-copy'
    alias paste='wl-paste'
elif command -v xclip >/dev/null 2>&1; then
    alias copy='xclip -selection clipboard'
    alias paste='xclip -selection clipboard -o'
fi

#################### UTILITY FUNCTIONS ####################

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

mkcd() { mkdir -p "$1" && cd "$1" || return; }

bak() { cp -r "$1" "$1.bak"; }

up() {
  local levels=${1:-1} path="."
  for ((i=0; i<levels; i++)); do path="$path/.."; done
  cd "$path" || return
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

iplocal() { hostname -I | awk '{print $1}'; }

cheat() { curl -s "cht.sh/$1"; }

#################### FZF FUNCTIONS ####################

if command -v fzf >/dev/null 2>&1; then
    fe() {
        local file
        file=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0)
        [[ -n "$file" ]] && ${EDITOR:-nvim} "$file"
    }

    fcd() {
        local dir
        dir=$(fd --type d --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0)
        [[ -n "$dir" ]] && cd "$dir" || return
    }

    fkill() {
        local pid
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
        if [[ -n "$pid" ]]; then
            echo "$pid" | xargs kill -"${1:-9}"
        fi
    }

    fshow() {
        local file
        file=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0 --preview "bat --color=always --style=numbers --line-range=:500 {}")
        [[ -n "$file" ]] && bat "$file"
    }
fi

#################### GIT FUNCTIONS ####################

gcom() { git add . && git commit -m "$1"; }

lazy() { git add . && git commit -m "$1" && git push; }

gclean() {
  git fetch -p
  git branch --merged | grep -E -v '(^\*|main|master|dev)' | xargs -r git branch -d
}

#################### ALIASES ####################

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# System
alias c='clear'
alias h='history'
alias path='echo -e "${PATH//:/\\n}"'
alias reload='source ~/.bashrc'
alias please='sudo $(fc -ln -1)'

# File operations
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
if command -v trash >/dev/null 2>&1; then
  alias rm='trash'
else
  alias rm='rm -i'
fi

# Listing (eza/lsd/ls)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -a -1 --icons --group-directories-first'
  alias l='eza -1 --icons --group-directories-first'
  alias la='eza -a -1 --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first --no-user --no-group --no-permissions --no-filesize --time=modified --time-style="%Y-%m-%d %H:%M"'
  alias lt='eza -T --level=2 --icons --group-directories-first'
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
alias grep='grep --color=auto --exclude-dir={.git,node_modules,vendor,build,dist}'
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

# Package management (distro-specific)
DISTRO=$(get_distro)
case "$DISTRO" in
  debian)
    alias install='sudo apt install'
    alias search='apt search'
    alias remove='sudo apt remove && sudo apt autoremove'
    ;;
  redhat)
    alias install='sudo dnf install'
    alias search='dnf search'
    alias remove='sudo dnf remove && sudo dnf autoremove'
    ;;
  arch)
    alias install='sudo pacman -S'
    alias search='pacman -Ss'
    alias remove='sudo pacman -R'
    ;;
esac
alias update='bash "$HOME/.local/bin/update.sh"'

# Editor
alias vim='nvim'
alias vi='nvim'
alias edit='${EDITOR}'

# Git
alias g='git'
alias gs='git status'
alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch --all'
alias ggraph='git log --graph --decorate --oneline --all'
alias gamend='git commit --amend --no-edit'
alias gca='git commit --amend'
alias gcp='git cherry-pick'
alias gprune='git fetch --prune'
alias guncommit='git reset --soft HEAD~1'

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
alias dexec='docker exec -it'

# Networking
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'
alias ippublic='curl -s https://ifconfig.me'

# Web servers
alias serve='python3 -m http.server 8000'

# Custom scripts
alias sweep='bash "$HOME/.local/bin/cleanup_storage.sh"'
alias wall='bash "$HOME/.local/bin/random-wall.sh"'
alias weather='curl -s "wttr.in?m"'

#################### KEYBINDINGS ####################

bind '"\C-f":"zi\n"' 2>/dev/null

#################### PROMPT & ENHANCEMENTS ####################

command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

#################### X11 AUTO-START ####################

if [[ -z "$DISPLAY" ]] && [[ "$(tty)" = "/dev/tty1" ]]; then
  exec startx
fi

#################### EXTERNAL SOURCES ####################

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -d "$HOME/.mimocode/bin" ]] && export PATH="$HOME/.mimocode/bin:$PATH"
