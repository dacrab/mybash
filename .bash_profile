#!/usr/bin/env bash

# Login shells: load POSIX profile first (env for all shells)
if [ -f "$HOME/.profile" ]; then
  . "$HOME/.profile"
fi

# For interactive Bash login shells, also load the main Bash config
if [[ -n $BASH && $- == *i* && -f "$HOME/.bashrc" ]]; then
  . "$HOME/.bashrc"
fi

export PATH=$PATH:/home/dacrab/.spicetify
