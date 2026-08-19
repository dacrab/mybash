# shellcheck shell=bash
# ----- Aliases: Files & Navigation -----
has eza && alias ls='eza -a -1 --icons --group-directories-first'
has bat && alias cat='bat'
alias grep='grep --color=auto --exclude-dir={.git,node_modules,vendor,build,dist}'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias reload='source ~/.bashrc'
alias dot='cd "$DOTFILES_DIR"'
alias dev='cd "$DEV_DIR"'

# ----- Aliases: File Safety -----
alias cp='cp -i'
alias mv='mv -i'
has trash && alias rm='trash'
alias mkdir='mkdir -pv'

# ----- Aliases: Text & Editors -----
has nvim && { alias vim='nvim'; alias vi='nvim'; }
alias tree='tree -C'

# ----- Aliases: System -----
has duf    && alias df='duf'
has dust   && alias du='dust'
alias free='free -h'
has procs  && alias ps='procs'
has btm    && alias top='btm'
has doggo  && alias dig='doggo'
has tldr   && alias help='tldr'
has http   && alias https='http'
alias shutdown='systemctl poweroff'
alias reboot='systemctl reboot'
alias py='python3'
alias diff='diff --color=auto'

# ----- Aliases: Network -----
alias ip='ip -c'
alias ping='ping -c 5'
alias wget='wget -c'
alias curl='curl -L'

# ----- Aliases: Scripts -----
alias update='update.sh'
alias sweep='sweep.sh'

# ----- Aliases: Dev Tools -----
alias gcl='gh repo clone'
alias adbsh='adb shell'

# ----- Misc -----
alias stripe='docker run --rm -it -v "$HOME/.config/stripe:/root/.config/stripe" -v "$HOME/.stripe:/root/.stripe" stripe/stripe-cli:latest'