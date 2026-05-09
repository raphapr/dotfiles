#!/bin/bash

set -euo pipefail

readonly FONT_DIR="$HOME/.local/share/fonts"
readonly AWS_CLI_GPG_FINGERPRINT="FB5DB77FD5C118B80511ADA8A6310ACC4672475C"

confirm_install() {
  local description="$1"
  local reply=""

  if [[ -t 0 ]]; then
    read -r -p "Install $description? [y/N] " reply
  elif read -r -p "Install $description? [y/N] " reply 2>/dev/null </dev/tty; then
    :
  else
    echo "No TTY available; skipping $description."
    exit 0
  fi

  case "${reply,,}" in
  y | yes) ;;
  *)
    echo "Skipping $description."
    exit 0
    ;;
  esac
}

confirm_install "extra packages"

echo ">> Installing extra packages..."

########################################################
# mise
########################################################

cargo install cargo-binstall
cargo binstall mise

pushd "$HOME" >/dev/null
mise install
mise upgrade
popd >/dev/null

########################################################
# yazi
########################################################

ya pack -a yazi-rs/flavors:catppuccin-mocha
ya pack -a dedukun/bookmarks
ya pack --upgrade

########################################################
# fonts
########################################################

mkdir -p "$FONT_DIR"
cp -rf "$HOME"/.config/rofi/fonts/* "$FONT_DIR"
fc-cache

########################################################
# virtualfish
########################################################

pip install --upgrade --user pip
pip install --upgrade --no-deps --user virtualenv filelock distlib virtualfish
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

install_gh_extension() {
  local repo="$1"

  if gh extension list | awk '{print $2}' | grep -qx "$repo"; then
    echo "GitHub CLI extension $repo already installed."
    return 0
  fi

  gh extension install "$repo"
}

install_gh_extension dlvhdr/gh-dash
install_gh_extension seachicken/gh-poi

########################################################
# awscli
########################################################

if ! command -v gpg >/dev/null 2>&1; then
  echo "gpg is required to verify the AWS CLI installer." >&2
  exit 1
fi

AWS_TMP_DIR="$(mktemp -d)"
cleanup_aws_tmp_dir() {
  rm -rf "$AWS_TMP_DIR"
}
trap cleanup_aws_tmp_dir EXIT

pushd "$AWS_TMP_DIR" >/dev/null
curl -fsSLO "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
curl -fsSLO "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig"

if ! gpg --list-keys "$AWS_CLI_GPG_FINGERPRINT" >/dev/null 2>&1; then
  gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys "$AWS_CLI_GPG_FINGERPRINT"
fi

actual_fingerprint="$(gpg --with-colons --fingerprint "$AWS_CLI_GPG_FINGERPRINT" | awk -F: '$1 == "fpr" { print $10; exit }')"
if [[ "$actual_fingerprint" != "$AWS_CLI_GPG_FINGERPRINT" ]]; then
  echo "Unexpected AWS CLI signing key fingerprint: $actual_fingerprint" >&2
  exit 1
fi

gpg --verify awscli-exe-linux-x86_64.zip.sig awscli-exe-linux-x86_64.zip
unzip -q awscli-exe-linux-x86_64.zip
./aws/install --update -i ~/.local/aws-cli -b ~/.local/bin
popd >/dev/null

cleanup_aws_tmp_dir
trap - EXIT

########################################################
# kanata
########################################################

if [ "$(hostname)" = "bmo" ]; then
  if ! getent group uinput >/dev/null; then
    sudo groupadd --system uinput
  fi
  sudo usermod -aG input "$USER"
  sudo usermod -aG uinput "$USER"
  echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' |
    sudo tee /etc/udev/rules.d/99-input.rules >/dev/null

  sudo udevadm control --reload-rules
  sudo udevadm trigger

  sudo modprobe uinput

  systemctl --user --now enable kanata
fi

########################################################
# set fish shell theme
########################################################

fish -c 'fish_config theme save "catppuccin-mocha"'
