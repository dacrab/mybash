#!/usr/bin/env bash
# ============================================
# .bashrc — interactive bash configuration.
# Shell behavior, environment, aliases, fzf.
# ============================================
[[ $- != *i* ]] && return

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

# ----- Environment -----
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

export EDITOR="nvim" VISUAL="nvim"
has bat && export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/.local/bin:$PATH"
[[ -f "$HOME/.atuin/bin/env" ]] && ! has atuin && source "$HOME/.atuin/bin/env"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"
[[ -d "$HOME/.spicetify" ]] && export PATH="$HOME/.spicetify:$PATH"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ----- Init Hooks -----
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
[[ -f "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash" && export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
has starship && eval "$(starship init bash)"
has zoxide  && eval "$(zoxide init bash)"
has atuin   && eval "$(atuin init bash)"
has direnv  && eval "$(direnv hook bash)"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"

# ----- Startup -----
has fastfetch && fastfetch

# ----- Directories (override via env) -----
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
DEV_DIR="${DEV_DIR:-$HOME/Documents/GitHub}"

# ----- Aliases: Files & Navigation -----
has wl-copy && alias copy='wl-copy' && alias paste='wl-paste'
has eza && {
  alias ls='eza -a -1 --icons --group-directories-first'
  alias l='eza -1 --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first --no-user --no-group --no-permissions --no-filesize --time=modified --time-style="%Y-%m-%d %H:%M"'
  alias lt='eza -T --level=2 --icons --group-directories-first'
  alias l.='eza -a --icons --only-dirs'
  alias la='ll -a'
}
has bat && alias cat='bat'
alias grep='grep --color=auto --exclude-dir={.git,node_modules,vendor,build,dist}'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history'
alias path='printf "%s\n" "${PATH//:/$'\''\n'\''}"'
alias reload='source ~/.bashrc'
alias eb='$EDITOR "$DOTFILES_DIR/mybash/.bashrc"'
alias eg='$EDITOR "$DOTFILES_DIR/git-stow/.gitconfig"'
alias dot='cd "$DOTFILES_DIR"'
alias dev='cd "$DEV_DIR"'

# ----- Aliases: File Safety -----
alias cp='cp -i'
alias mv='mv -i'
has trash && alias rm='trash' || alias rm='rm -i'
alias mkdir='mkdir -pv'

# ----- Aliases: Text & Editors -----
has nvim && { alias vim='nvim'; alias vi='nvim'; }
alias tree='tree -C'
alias untar='tar -xvf'
alias targz='tar -czvf'

# ----- Aliases: System -----
has duf    && alias df='duf'    || alias df='df -h'
has dust   && alias du='dust'   || alias du='du -h'
alias free='free -h'
has procs  && alias ps='procs'  || alias ps='ps auxf'
alias psg='ps aux | grep'
has kiro-cli && alias k='kiro-cli'
has btm    && alias top='btm' || has htop && alias top='htop'
has doggo  && alias dig='doggo'
has tldr   && alias help='tldr'
has http   && alias https='http'
alias please='sudo $(fc -ln -1)'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias sc='systemctl'
alias jc='journalctl'
alias py='python3'
alias diff='diff --color=auto'

# ----- Aliases: Network -----
has ss && alias ports='ss -tulpen'
alias ip='ip -c'
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'
alias ippublic='curl -s https://ifconfig.me'
alias serve='python3 -m http.server 8000'
alias weather='curl -s "wttr.in?m"'

# ----- Aliases: Git -----
alias g='git'
alias gs='git status'
alias gst='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch --all'
alias ggraph='git log --graph --decorate --oneline --all'
alias gamend='git commit --amend --no-edit'
alias gcp='git cherry-pick'
alias gaa='git add --all'
alias grh='git reset HEAD'
alias gstash='git stash'
alias gstashp='git stash pop'
alias gprune='git fetch --prune'
alias guncommit='git reset --soft HEAD~1'
alias gundo='git restore .'
alias gpf='git push --force-with-lease'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git log -1 --oneline | grep -q WIP && git reset --soft HEAD~1'

# ----- Aliases: Docker -----
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dclean='docker system prune -af'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcl='docker compose logs -f'
alias dexec='docker exec -it'

# ----- Aliases: New Tools -----
has lazygit && alias lg='lazygit'
has yt-dlp  && alias yt='yt-dlp'
has yt-dlp  && alias yta='yt-dlp -x --audio-format mp3'

# ----- Aliases: Scripts -----
alias update='update.sh'
alias sweep='sweep.sh'
alias wall='random-wall.sh'

# ----- Aliases: JS/TS (bun preferred, npm fallback) -----
has bun && {
  alias ni='bun install'
  alias nadd='bun add'
  alias nrd='bun run dev'
  alias nr='bun run'
  alias nx='bunx'
} || {
  alias ni='npm install'
  alias nrd='npm run dev'
  alias nr='npm run'
}

# ----- Aliases: Supabase -----
has supabase && {
  alias supau='supabase start'
  alias supad='supabase stop --all'
}

# ----- Functions: Git -----
gcom()  { git add . && git commit -m "$1"; }
lazy()  { git add . && git commit -m "$1" && git push; }
gclean(){
  git fetch -p
  local b
  while read -r b; do
    [[ "$b" == "*"* || "$b" == main || "$b" == master || "$b" == dev ]] && continue
    git branch -d "$b" 2>/dev/null
  done < <(git branch --merged)
}
fbr()   { local b; b=$(git branch -a --format '%(refname:short)' | fzf) && [[ -n "$b" ]] && git checkout "$b"; }

# ----- Functions: Project -----
cleanb(){ rm -rf .next .astro .svelte-kit node_modules/.cache 2>/dev/null; echo "build artifacts removed"; }

# ----- Functions: FZF -----
if has fzf && has fd; then
  fe()   { local f; f=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0) && ${EDITOR:-nvim} "$f"; }
  fcd()  { local d; d=$(fd --type d --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0) && cd "$d" || return; }
  fkill(){ local p; p=$(ps -eo pid=,comm= | fzf -m) && [[ -n "$p" ]] && while read -r pid _; do kill -"${1:-9}" "$pid"; done <<< "$p"; }
  fshow(){ local f; f=$(fd --type f --hidden --exclude .git | fzf --query="$1" --select-1 --exit-0 --preview "bat --color=always --style=numbers --line-range=:500 {}") && bat "$f"; }
fi

# ----- Misc -----
alias stripe='docker run --rm -it -v "$HOME/.config/stripe:/root/.config/stripe" -v "$HOME/.stripe:/root/.stripe" stripe/stripe-cli:latest'
