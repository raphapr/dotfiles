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

pip install --upgrade --no-deps --break-system-packages virtualenv filelock distlib

if ! pip show virtualfish &>/dev/null; then
  pip install --upgrade --no-deps --break-system-packages virtualfish
  vf install
  vf addplugins global_requirements
  exec fish
else
  echo "virtualfish is already installed."
fi

# neovim virtualenv
fish -c "
vf new neovim
vf activate neovim
pip install neovim
vf deactivate
"

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

########################################################
# flatpak
########################################################
flatpak install flathub com.rtosta.zapzap --system
