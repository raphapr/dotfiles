# dotfiles

Personal dotfiles for Arch-based Linux systems, managed with [chezmoi](https://chezmoi.io). This setup provides an opinionated GNU/Linux configuration focused around i3wm, along with a curated selection of (mostly) open source tools. While these dotfiles are configured to work on my systems, requiring personal dependencies, you are welcome to adapt them to fit your own needs.

## Installation

### Quick Start

```bash
sudo pacman -S chezmoi
# Install the 1Password CLI (`op`) before applying secret-backed templates.
eval $(op signin)
chezmoi init raphapr --apply
```

### Manual Setup

1. Install chezmoi:

   ```bash
   sudo pacman -S chezmoi
   ```

2. Sign in to 1Password before rendering secret-backed templates:

   ```bash
   eval $(op signin)
   ```

3. Initialize and apply:
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
- **sesh** - tmux session manager
- **workmux** - Parallel development in tmux with git worktrees

### Editor & Development

- **neovim** - Best editor ever
- **direnv** - Environment variable manager
- **mise** - Development tool version and package manager
- **neogit** - Magit-style git interface for Neovim

### File Management

- **yazi** - Terminal file manager
- **thunar** - GUI file manager
- **zoxide** - Smarter cd command

### Browser

- **firefox** - Web browser
- **tridactyl** - Vim-like keybindings for Firefox

### Utilities

- **fzf** - Fuzzy finder
- **ripgrep** - Fast text search
- **btop** - System monitor
- **greenclip** - Clipboard manager
- **flameshot** - Screenshot tool
- **atuin** - Shell history with sync
- **zathura** - Document viewer
- **k9s** - Kubernetes CLI manager
- **kubie** - Kubernetes context and namespace switcher
- **zk** - Plain text note-taking
- **bat** - `cat` clone with syntax highlighting and git integration
- **eza** - Modern replacement for `ls`
- **ghq** - Git repository management tool

### Agentic Development

- **pi** - Terminal-based AI coding agent
- **cymbal** - Language-agnostic code navigation CLI
- **headroom** - Context-compression layer for AI agents

### System

- **chezmoi** - Dotfiles manager
- **yay** - AUR helper
