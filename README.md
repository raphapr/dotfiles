# dotfiles

This repository contains configuration files I use on my Manjaro GNU/Linux which have been inspired by the rest of the dotfiles community. 

## Install

Install homesick first:

`gem install homesick`

Next, you need to clone this repository:

`homesick clone raphapr/dotfiles`

You can now link its contents into your home dir:

`homesick symlink dotfiles`

### Pacman/yaourt install script

`chmod +x ~/.yaourt && ./.yaourt`

### Neovim

Install plug.vim

`curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

## Main programs

* neovim
* i3wm
* i3blocks
* fish shell
* tmux
* ranger
* glances
* firefox
* thunar
* imgurbash
* urxvt
* transmission-remote-cli
* zathura
* fasd
* translate-shell
* youtube-dl
* feh
* fzf
* gist
* rofi
* scrot
* htop
* ncmpcpp
* mopidy
