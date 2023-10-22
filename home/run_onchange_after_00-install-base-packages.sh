#!/bin/bash

# Update the system
echo ">> Installing base packages..."
sudo pacman -Syu --needed

# List of packages to install, one per line
packages=(
  "yay"
  "vim"
  "python"
  "python-pip"
  "fish"
  "make"
  "cmake"
  "gcc"
  "fakeroot"
  "patch"
  "dnsutils"
  "nodejs"
  "npm"
  "wget"
  "unzip"
  "cronie"
  "git"
  "gopls"
)

for pkg in "${packages[@]}"; do
  if ! pacman -Qs "$pkg" &>/dev/null; then
    sudo pacman -S --noconfirm --needed "$pkg" || echo "$pkg failed." >>"$PKGLOG"
  else
    echo "$pkg is already installed."
  fi
done
