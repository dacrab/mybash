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
# NOTE: `history -a` is appended to PROMPT_COMMAND at the end of hooks.sh,
# after the tool inits (atuin/starship/zoxide/direnv) have set it up.

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

if has nvim; then
  export EDITOR="${EDITOR:-nvim}"
  export VISUAL="${VISUAL:-$EDITOR}"
fi
has bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
# Listed lowest-priority first: each entry is prepended, so ~/.local/bin wins.
for dir in "$HOME/.spicetify" "$HOME/.opencode/bin" "$BUN_INSTALL/bin" "$HOME/go/bin" "$HOME/.local/bin"; do
  [[ -d "$dir" ]] || continue
  [[ ":$PATH:" == *":$dir:"* ]] || export PATH="$dir${PATH:+:$PATH}"
done

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

# ----- Directories (override via env) -----
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
export DEV_DIR="${DEV_DIR:-$HOME/Documents/GitHub}"