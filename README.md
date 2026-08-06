# mybash

My personal Bash setup — shell configuration and a Starship prompt. It's a git submodule of [dacrab/dotfiles](https://github.com/dacrab/dotfiles).

## What's inside

| File | Purpose |
|------|---------|
| `.bashrc` | Main shell setup: aliases, functions, init hooks (starship, zoxide, atuin, direnv, fzf) |
| `.bash_profile` | Login shell entry point, loads `.profile` and `.bashrc` |
| `.profile` | Environment setup for non-Bash logins |
| `.config/starship/starship.toml` | The prompt theme |

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
