# mybash

Bash configuration (.bashrc, .bash_profile) and Starship prompt, managed as a git submodule of [dacrab/dotfiles](https://github.com/dacrab/dotfiles).

## Structure

```
mybash/
├── .bashrc              # Main bash configuration
├── .bash_profile        # Login shell setup
├── .config/
│   └── starship/
│       └── starship.toml
└── README.md
```

## Install

```bash
stow mybash
```

## Updating

```bash
cd ~/dotfiles/mybash && git pull
```

## Original repo

Maintained at [dacrab/mybash](https://github.com/dacrab/mybash).
