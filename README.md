# dotfiles

This repository contains configuration files I use on my Manjaro GNU/Linux which has been inspired by the rest of the dotfiles community.

## Install

Run this:

```bash
git clone https://github.com/raphapr/dotfiles ~/dotfiles
cd ~/dotfiles && chmod +x ./home/.bin/bootstrap
./home/.bin/bootstrap
```

## Symlink dotfiles

Install homesick:

`gem install homesick`

Next, you need to clone this repository:

`homesick clone raphapr/dotfiles`

You can now link its contents into your home dir:

`homesick symlink dotfiles`

## Main programs

- neovim
- i3wm
- polybar
- fish shell
- tmux
- ranger
- thunar
- kitty
- zathura
- zoxide
- feh
- fzf
- rofi
- htop
- copyq
- direnv
- flameshot
- ripgrep
- autorandr
- redshift
- asdf
- yay
