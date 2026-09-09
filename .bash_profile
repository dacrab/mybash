#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null
# .bash_profile — sources .profile and .bashrc.
[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -n $BASH && $- == *i* && -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

. "$HOME/.local/share/../bin/env"
