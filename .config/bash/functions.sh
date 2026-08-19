# shellcheck shell=bash
# ----- Functions -----
# Run `aliases` for a text list; it also syncs the `navi` cheat sheet.
aliases() {
  local sheet="$HOME/.local/share/navi/cheats/aliases.cheat"
  mkdir -p "${sheet%/*}"
  awk -v sheet="$sheet" '
    /^# -----/ { sub(/^# ----- /, ""); sub(/ -----$/, ""); sec = $0; shown = 0; next }
    {
      rest = $0
      if (rest ~ /^(has [^ ]+ +&& +)?(\{ )?alias /) {
        if (!shown) {
          print "\n" sec ":"
          print "% " sec > sheet
          shown = 1
        }
        sub(/^has [^ ]+ +&& +/, "", rest)
        sub(/^\{ /, "", rest)
        sub(/^alias /, "", rest)
        sub(/\}$/, "", rest)
        n = split(rest, parts, /;/)
        for (i = 1; i <= n; i++) {
          p = parts[i]
          gsub(/^ +| +$/, "", p)
          sub(/^alias /, "", p)
          if (p ~ /=/) {
            name = p; sub(/=.*/, "", name); gsub(/['\''"]/, "", name)
            val = p; sub(/^[^=]*=/, "", val); gsub(/^['\''"]|['\''"]$/, "", val)
            printf "  %-10s %s\n", name, val
            printf "# %s: %s\necho %s: %s\n", name, val, name, val > sheet
          }
        }
      }
    }
  ' "$DOTFILES_DIR/mybash/.config/bash/aliases.sh"
}

# Refresh the navi cheat sheet when the aliases change.
for f in "$HOME/.bashrc" "$HOME/.config/bash/aliases.sh"; do
  [[ "$f" -nt "$HOME/.local/share/navi/cheats/aliases.cheat" ]] && { aliases >/dev/null; break; }
done