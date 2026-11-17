# shellcheck shell=bash
# y: open yazi and cd to the directory it was left in.
y() {
  local tmp cwd status
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  yazi "$@" --cwd-file="$tmp"
  status=$?
  if cwd="$(command cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd" || status=$?
  fi
  command rm -f -- "$tmp"
  return "$status"
}

