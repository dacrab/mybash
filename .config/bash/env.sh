# shellcheck shell=bash source=/dev/null
# ----- Environment -----
has() { command -v "$1" &>/dev/null; }

# ----- Shell Behavior -----
[[ -f /etc/bashrc ]] && source /etc/bashrc
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion

shopt -s checkwinsize histappend
bind "set bell-style none" 2>/dev/null
bind "set completion-ignore-case on" 2>/dev/null
stty -ixon 2>/dev/null

export HISTSIZE=10000 HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL="erasedups:ignoredups:ignorespace"
PROMPT_COMMAND="history -a"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export EDITOR="nvim" VISUAL="nvim"
has bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/go/bin" ]] && export PATH="$HOME/go/bin:$PATH"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"
[[ -d "$HOME/.spicetify" ]] && export PATH="$HOME/.spicetify:$PATH"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

# ----- Directories (override via env) -----
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
DEV_DIR="${DEV_DIR:-$HOME/Documents/GitHub}"