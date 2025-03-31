#!/bin/bash

declare -r FONT_DIR=$HOME/.local/share/fonts

echo ">> Installing extra packages..."

########################################################
# mise
########################################################

cargo install cargo-binstall
cargo binstall mise

pushd "$HOME" || exit
mise install
mise upgrade
popd || exit

########################################################
# yazi
########################################################

ya pack -a yazi-rs/flavors:catppuccin-mocha
ya pack -a dedukun/bookmarks
ya pack --upgrade

########################################################
# fonts
########################################################

if [[ ! -d "$FONT_DIR" ]]; then
  mkdir -p "$FONT_DIR"
fi
cp -rf "$HOME"/.config/rofi/fonts/* "$FONT_DIR"
fc-cache

########################################################
# virtualfish
########################################################

pip install --upgrade --break-system-packages pip
pip install --upgrade --no-deps --break-system-packages virtualenv filelock distlib virtualfish
vf install
vf addplugins global_requirements

########################################################
# npm
########################################################

if [ ! -d "${HOME}/.npm-packages" ]; then
  mkdir "${HOME}/.npm-packages"
  npm config set prefix "${HOME}/.npm-packages"
else
  echo "npm packages directory already exists."
fi

########################################################
# fzf
########################################################

if [[ ! -f "$HOME"/.fzf/bin/fzf ]]; then
  echo -e "y" | ~/.fzf/install --no-bash --no-zsh
fi

########################################################
# github cli extensions
########################################################

gh extension install dlvhdr/gh-dash
gh extension install seachicken/gh-poi

########################################################
# awscli
########################################################
pushd /tmp || exit
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --update -i ~/.local/aws-cli -b ~/.local/bin
popd || exit
