# 🐚 MyBash Integration

This directory contains the Stow-compatible structure for the mybash configuration, sourced from the [mybash repository](https://github.com/dacrab/mybash).

## 📁 Structure

```
mybash-stow/
├── .bashrc              # Main bash configuration
├── .config/
│   └── starship/
│       └── starship.toml # Starship prompt configuration
└── README.md            # This file
```

## 🔧 Installation

To install the mybash configuration:

```bash
# Install mybash configuration
stow mybash-stow

# Or install all dotfiles including mybash
stow hypr hyprpanel rofi mybash-stow
```

## 🚀 Features

- **Custom bash configuration** with aliases, functions, and environment setup
- **Starship prompt** for a modern, fast shell experience
- Starship prompt configuration (static)
- **Git integration** with the original mybash repository
- **Stow compatibility** for easy management

## 🔄 Updating

To update the mybash configuration from the original repository:

```bash
# Update the submodule
git submodule update --remote mybash

# Copy updated files to Stow structure
cp mybash/.bashrc mybash-stow/
cp mybash/starship.toml mybash-stow/.config/starship/

# Commit changes
git add .
git commit -m "Update mybash configuration"
```

## 📚 Original Repository

The original mybash configuration is maintained in a separate repository:
- **Repository**: [dacrab/mybash](https://github.com/dacrab/mybash)
- **Purpose**: Independent bash configuration management
- **Integration**: Added as git submodule to this dotfiles repo

## 🎨 Theming

Dynamic theming integration has been removed. The Starship prompt uses the provided `starship.toml` as-is.

## 🛠️ Customization

To modify the bash configuration:

1. **Edit the original files** in the `mybash/` submodule directory
2. **Copy changes** to the `mybash-stow/` directory
3. **Commit both** the submodule and the Stow structure

This approach maintains the separation of concerns while allowing integration with the main dotfiles repository.
