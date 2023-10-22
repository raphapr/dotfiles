#!/bin/bash

declare -r PKGLIST=$HOME/.pkglist
declare -r PKG_AUR=$PKGLIST/aur

PKGLOG="/tmp/install-aur-packages.log"

echo "Install AUR packages..."
for pkg in $(cat "$PKG_AUR"); do
  if ! yay -Qs "$pkg" &>/dev/null; then
    yay -S --needed --noconfirm "$pkg" || echo "$pkg failed." >>"$PKGLOG"
  else
    echo "$pkg is already installed."
  fi
done

# pushd "$HOME" || exit
# asdf install
# popd || exit
