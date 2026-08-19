# mybash

My personal Bash setup — shell configuration and a Starship prompt. It's a git submodule of [dacrab/dotfiles](https://github.com/dacrab/dotfiles).

## What's inside

| File | Purpose |
|------|---------|
| `.bashrc` | Thin entry point; sources `~/.config/bash/*.sh` |
| `.config/bash/env.sh` | Shell behavior, history, XDG vars, PATH, editor |
| `.config/bash/aliases.sh` | All shell aliases |
| `.config/bash/functions.sh` | `aliases` command — prints shortcuts and syncs the navi sheet |
| `.config/bash/hooks.sh` | Init hooks (starship, zoxide, atuin, direnv, fzf) |
| `.config/navi/config.yaml` | navi cheatsheet paths |
| `.config/navi/cheats/my.cheat` | Your personal navi cheatsheet — add commands you forget |
| `.bash_profile` | Login shell entry point, loads `.profile` and `.bashrc` |
| `.profile` | Environment setup for non-Bash logins |
| `.config/starship/starship.toml` | The prompt theme |

## Cheatsheets

Run `aliases` for a grouped shortcut list, or `navi` to fuzzy-browse. Two sources:
- `aliases.cheat` — auto-generated from `aliases.sh` into `~/.local/share/navi/cheats/` (refreshed when it changes)
- `my.cheat` — hand-written; add snippets there (`%` section, `#` description, command)

## Install

```bash
cd ~/dotfiles
stow mybash
```

## Update

```bash
cd ~/dotfiles/mybash
git pull
```

Maintained at [dacrab/mybash](https://github.com/dacrab/mybash).
