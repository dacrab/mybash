#!/usr/bin/env bash
# shellcheck source=/dev/null
# .bashrc — interactive bash configuration.
[[ $- != *i* ]] && return

for f in "$HOME/.config/bash"/{env,aliases,functions,hooks}.sh; do
  [[ -r "$f" ]] && source "$f"
done

# API keys (untracked)
[[ -r "$HOME/.secrets.env" ]] && . "$HOME/.secrets.env"

. "$HOME/.local/bin/env"
