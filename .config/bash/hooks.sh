# shellcheck shell=bash source=/dev/null
# ----- Init Hooks -----
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
has fzf       && eval "$(fzf --bash)"
has starship && eval "$(starship init bash)"
has zoxide  && eval "$(zoxide init bash)"
has atuin   && eval "$(atuin init bash)"
has direnv  && eval "$(direnv hook bash)"

# Sync history to HISTFILE after every command. Last so the tool inits
# above (which rebuild PROMPT_COMMAND) can't drop it; guarded for `reload`.
# shellcheck disable=SC2178,SC2128 # branches handle array vs string exclusively
if [[ "$(declare -p PROMPT_COMMAND 2>/dev/null)" == "declare -a"* ]]; then
  [[ " ${PROMPT_COMMAND[*]} " == *"history -a"* ]] || PROMPT_COMMAND+=("history -a")
else
  [[ ";${PROMPT_COMMAND:-};" == *";history -a;"* ]] \
    || PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}history -a"
fi

# ----- Startup -----
has fastfetch && fastfetch
