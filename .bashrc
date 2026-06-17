#!/usr/bin/env bash
[[ $- != *i* ]] && return

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
command -v bat &>/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

[[ -f "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash" && export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'

has() { command -v "$1" &>/dev/null; }

command -v wl-copy &>/dev/null && alias copy='wl-copy' && alias paste='wl-paste'

alias ls='eza -a -1 --icons --group-directories-first'
alias l='eza -1 --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --no-user --no-group --no-permissions --no-filesize --time=modified --time-style="%Y-%m-%d %H:%M"'
alias lt='eza -T --level=2 --icons --group-directories-first'
has bat && alias cat='bat'
alias grep='grep --color=auto --exclude-dir={.git,node_modules,vendor,build,dist}'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history'
alias path='echo -e "${PATH//:/\\n}"'
alias reload='source ~/.bashrc'
alias please='sudo $(fc -ln -1)'
alias cp='cp -i'
alias mv='mv -i'
has trash && alias rm='trash' || alias rm='rm -i'
alias mkdir='mkdir -pv'
alias vim='nvim'
alias vi='nvim'
alias tree='tree -C'
alias untar='tar -xvf'
alias targz='tar -czvf'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep'
has htop && alias top='htop'
has ss && alias ports='ss -tulpen'
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'
alias ippublic='curl -s https://ifconfig.me'
alias serve='python3 -m http.server 8000'
alias weather='curl -s "wttr.in?m"'

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
alias gcp='git cherry-pick'
alias gprune='git fetch --prune'
alias guncommit='git reset --soft HEAD~1'

alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dclean='docker system prune -af'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcl='docker compose logs -f'
alias dexec='docker exec -it'

alias update='bash "$HOME/.local/bin/update.sh"'
alias sweep='bash "$HOME/.local/bin/cleanup_storage.sh"'
alias wall='bash "$HOME/.local/bin/random-wall.sh"'

gcom() { git add . && git commit -m "$1"; }
lazy() { git add . && git commit -m "$1" && git push; }
gclean() { git fetch -p && git branch --merged | grep -E -v '(^\*|main|master|dev)' | xargs -r git branch -d; }

if has fzf && has fd; then
  fe()   { local f; f=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0) && ${EDITOR:-nvim} "$f"; }
  fcd()  { local d; d=$(fd --type d --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0) && cd "$d"; }
  fkill(){ local p; p=$(ps -ef | sed 1d | fzf -m | awk '{print $2}') && echo "$p" | xargs kill -"${1:-9}"; }
  fshow(){ local f; f=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0 --preview "bat --color=always --style=numbers --line-range=:500 {}") && bat "$f"; }
fi

bind '"\C-f":"zi\n"' 2>/dev/null

has starship && eval "$(starship init bash)"
has zoxide && eval "$(zoxide init bash)"

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
