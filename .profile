#!/bin/sh
# shellcheck shell=sh disable=SC1091
# Login/non-interactive environment. Keep this POSIX: it may be sourced by
# /bin/sh, not only by Bash.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"

# Lives outside the repo; never commit it.
[ -r "$HOME/.secrets.env" ] && . "$HOME/.secrets.env"
