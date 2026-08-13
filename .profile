#!/usr/bin/env bash
# shellcheck shell=bash
# ============================================
# .profile — login shell environment.
# Loads the Rust/cargo env and ~/.local/bin PATH
# helper for non-interactive login shells.
# ============================================
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"
