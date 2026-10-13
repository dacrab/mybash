#!/usr/bin/env bash
# shellcheck source=/dev/null
[[ $- != *i* ]] && return

for f in "$HOME/.config/bash"/{env,aliases,functions,hooks}.sh; do
  [[ -r "$f" ]] && source "$f"
done

# Lives outside the repo; never commit it.
[[ -r "$HOME/.secrets.env" ]] && . "$HOME/.secrets.env"

. "$HOME/.local/bin/env"
