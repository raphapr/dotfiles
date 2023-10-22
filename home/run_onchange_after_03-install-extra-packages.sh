#!/bin/bash

declare -r FONT_DIR=$HOME/.local/share/fonts

echo ">> Installing extra packages..."

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
  pip install --upgrade --no-deps virtualfish
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

npm_packages=("git-recent" "jsonlint")

for pkg in "${npm_packages[@]}"; do
  if ! npm list -g "$pkg" &>/dev/null; then
    npm install -g "$pkg"
  else
    echo "$pkg is already installed globally."
  fi
done

########################################################
# fzf
########################################################

if [[ ! -f "$HOME"/.fzf/bin/fzf ]]; then
  echo -e "y" | ~/.fzf/install --no-bash --no-zsh
fi

########################################################
# asdf
########################################################

asdf install
