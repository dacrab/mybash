#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

# Lives outside the repo; never commit it.
[[ -r "$HOME/.secrets.env" ]] && . "$HOME/.secrets.env"

. "$HOME/.local/share/../bin/env"
