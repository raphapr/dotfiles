# dotfiles

Personal dotfiles for Arch-based Linux systems, managed with [chezmoi](https://chezmoi.io). This setup provides an opinionated GNU/Linux configuration focused around i3wm, along with a curated selection of (mostly) open source tools. While these dotfiles are configured to work on my systems, requiring personal dependencies, you are welcome to adapt them to fit your own needs.

## Installation

### Quick Start

```bash
sudo pacman -S chezmoi
chezmoi init raphapr --apply
```

### Manual Setup

1. Install chezmoi:

   ```bash
   sudo pacman -S chezmoi
   ```

2. Initialize and apply:
   ```bash
   chezmoi init raphapr
   chezmoi apply
   ```

## Components

### Window Manager & Interface

- **i3wm** - Tiling window manager
- **polybar** - Status bar
- **rofi** - Application launcher and menu system
- **dunst** - Notification daemon
- **feh** - Image viewer and wallpaper setter
- **redshift** - Screen color temperature adjuster
- **autorandr** - Display configuration manager

### Terminal & Shell

- **kitty** - GPU-accelerated terminal emulator
- **fish** - Modern shell
- **starship** - Cross-shell prompt
- **tmux** - Terminal multiplexer

### Editor & Development

- **neovim** - Best editor ever
- **direnv** - Environment variable manager
- **mise** - Development tool version manager
- **lazygit** - Terminal UI for git

### File Management

- **yazi** - Terminal file manager
- **thunar** - GUI file manager
- **zoxide** - Smarter cd command

### Utilities

- **fzf** - Fuzzy finder
- **ripgrep** - Fast text search
- **btop** - System monitor
- **copyq** - Clipboard manager
- **flameshot** - Screenshot tool
- **atuin** - Shell history with sync
- **zathura** - Document viewer
- **tms** - tmux session manager
- **k9s** - Kubernetes CLI manager
- **zk** - Plain text note-taking

### System

- **chezmoi** - Dotfiles manager
- **yay** - AUR helper
- **psd** - Profile-sync-daemon for browser profile management

## Structure

```
.
├── home/
│   ├── .config/          # App configurations
│   ├── .bin/             # Custom scripts
│   ├── .i3/              # i3wm configuration
│   ├── .tmux/            # tmux configuration
│   └── run_*.sh          # Chezmoi setup scripts
```

## Features

- Automated package installation (base, official, AUR)
- Consistent theming with Catppuccin Mocha
- neovim setup with LSP support
- Custom scripts for battery monitoring, volume control, etc.
- Systemd user services for automation
- Kanata keyboard remapping configuration for laptops
