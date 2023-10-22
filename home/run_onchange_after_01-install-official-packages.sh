#!/bin/bash

declare -r PKGLIST=$HOME/.pkglist
declare -r PKG_OFFICIAL=$PKGLIST/official

echo ">> Installing official packages..."

########################################################
# pacman
########################################################

PKGLOG="/tmp/install-official-packages.log"

echo "Install official packages..."
for pkg in $(cat "$PKG_OFFICIAL"); do
  if ! pacman -Qs "$pkg" &>/dev/null; then
    sudo pacman -S --needed --noconfirm "$pkg" || echo "$pkg failed." >>"$PKGLOG"
  else
    echo "$pkg is already installed."
  fi
done
