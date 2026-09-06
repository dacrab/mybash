# mybash

My personal Bash setup — shell config plus a Starship prompt. It's part of [dacrab/dotfiles](https://github.com/dacrab/dotfiles), where it lives as a linked sub-repo.

## What's inside

| File | Purpose |
| ---- | ------- |
| `.bashrc` | Thin entry point; loads the files below |
| `.config/bash/env.sh` | History, folder locations, PATH, default editor |
| `.config/bash/aliases.sh` | All shell shortcuts (`ls`, `cat`, `update`, ...) |
| `.config/bash/functions.sh` | The `aliases` command — prints your shortcuts and keeps the navi cheatsheet in sync |
| `.config/bash/hooks.sh` | Starts shell tools (prompt, zoxide, atuin, fzf) |
| `.config/navi/config.yaml` | Where navi looks for cheatsheets |
| `.config/navi/cheats/my.cheat` | Your personal cheatsheet — add commands you keep forgetting |
| `.bash_profile` | Login shell entry point, loads `.profile` and `.bashrc` |
| `.profile` | Environment setup for other shells and programs |
| `.config/starship/starship.toml` | The prompt theme |

## Shortcuts

Run `aliases` any time for a grouped list of your shortcuts, or `navi` to browse them interactively. The list stays in sync automatically whenever `aliases.sh` changes.

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
