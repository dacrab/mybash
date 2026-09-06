# shellcheck shell=bash source=/dev/null
# ----- Init Hooks -----
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
has fzf       && eval "$(fzf --bash)"
has starship && eval "$(starship init bash)"
has zoxide  && eval "$(zoxide init bash)"
has atuin   && eval "$(atuin init bash)"
has direnv  && eval "$(direnv hook bash)"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"

# ----- Startup -----
has fastfetch && fastfetch