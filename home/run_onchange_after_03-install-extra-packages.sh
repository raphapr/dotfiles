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
popd || exit

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

if ! pip show virtualfish &>/dev/null; then
  pip install --upgrade --no-deps --break-system-packages virtualfish
  vf install
  vf addplugins global_requirements
  exec fish
else
  echo "virtualfish is already installed."
fi

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
