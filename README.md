# 🐚 mybash

Opinionated Bash setup with a Nord‑themed Starship prompt, sensible defaults, and a bunch of productivity aliases and functions.

This repo is the **source of truth** for your Bash config. It is also used by the `mybash-stow` package in [`dacrab/dotfiles`](https://github.com/dacrab/dotfiles), but it can be used completely standalone.

---

## ✨ Features

- **Interactive‑only config** – exits early for non‑interactive shells
- **Smart `ls` / directory navigation**
  - Uses `eza`, `exa`, or `lsd` when available, falls back to `ls`
  - Overrides `cd` to automatically list the target directory
  - Handy helpers: `mkcd`, `up`, `search_files`
- **History + quality‑of‑life tweaks**
  - Large history with timestamps
  - No duplicate / leading‑space commands
  - sane readline, disabled terminal bell, `stty -ixon`
- **Git shortcuts** – `g`, `gs`, `gc`, `gp`, `ggraph`, `gclean`, `lazy "msg"`, etc.
- **Package manager aliases** – automatically pick `dnf`, `apt`, or `pacman` based on distro
- **Developer tooling** – `nvim` as default editor, Docker and Python helpers, quick HTTP server
- **Network helpers** – `myip`, `iplocal`, `ippublic`
- **Prompt** – [Starship](https://starship.rs) config with Nord palette and git/status segments

---

## 📁 Layout

```
mybash/
├── .bashrc                     # Main Bash configuration
└── .config/
    └── starship/
        └── starship.toml       # Starship prompt configuration
```

---

## 🚀 Getting started

> These steps assume you want to manage your Bash config from this repo directly.

1. **Clone the repo**

   ```bash
   git clone https://github.com/dacrab/mybash.git ~/mybash
   cd ~/mybash
   ```

2. **Point Bash at this `.bashrc`** (symlink recommended)

   ```bash
   ln -sf "$HOME/mybash/.bashrc" "$HOME/.bashrc"
   ```

3. **Set up Starship config (optional but recommended)**

   ```bash
   mkdir -p "$HOME/.config/starship"
   ln -sf "$HOME/mybash/.config/starship/starship.toml" \
     "$HOME/.config/starship/starship.toml"
   ```

4. **Install recommended tools** (as needed)

   - [`starship`](https://starship.rs)
   - [`zoxide`](https://github.com/ajeetdsouza/zoxide)
   - One of: `eza`, `exa`, or `lsd`
   - `fastfetch` for the startup system info (optional)

5. **Start a new shell**

   ```bash
   exec bash
   ```

You should now see the Starship prompt and have all aliases/functions available.

---

## 🔄 Updating

To pull in the latest changes from this repo:

```bash
cd ~/mybash
git pull
exec bash  # or `source ~/.bashrc`
```

If you're using `mybash` via the `mybash-stow` package in `dacrab/dotfiles`, keep following the sync workflow defined there; this repo is the upstream.

---

## 🛠 Customization

You can safely tweak any of the following:

- **Aliases / functions** – adjust or remove ones you don't use in `.bashrc`
- **Prompt** – edit `.config/starship/starship.toml` to change colors, segments, or layout
- **PATH / tools** – add language toolchains or CLIs you use often

If you break something, you can always reset to the latest version:

```bash
cd ~/mybash
git restore .
```

---

## 📚 Related

- Dotfiles repo that consumes this config: [`dacrab/dotfiles`](https://github.com/dacrab/dotfiles)
- Starship docs: https://starship.rs/config/
- Bash manual: https://www.gnu.org/software/bash/manual/bash.html
