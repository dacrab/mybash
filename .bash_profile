#!/usr/bin/env bash

# Login shells: load POSIX profile first (env for all shells)
# shellcheck source=/dev/null
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

# For interactive Bash login shells, also load the main Bash config
if [[ -n $BASH && $- == *i* && -f "$HOME/.bashrc" ]]; then
  . "$HOME/.bashrc"
fi

# PATH additions for non-interactive login shells (duplicates in .bashrc are harmless)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
