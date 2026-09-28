#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null
# .profile — non-interactive login shell environment.
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"
