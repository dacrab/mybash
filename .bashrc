#!/usr/bin/env bash
# shellcheck source=/dev/null
# .bashrc — interactive bash configuration.
[[ $- != *i* ]] && return

for f in "$HOME/.config/bash"/{env,aliases,functions,hooks}.sh; do
  [[ -f "$f" ]] && source "$f"
done

. "$HOME/.local/share/../bin/env"
