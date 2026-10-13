#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null
[[ -f "$HOME/.profile" ]] && . "$HOME/.profile"
[[ -n "${BASH:-}" && $- == *i* && -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
