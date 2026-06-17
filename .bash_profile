[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -n $BASH && $- == *i* && -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
