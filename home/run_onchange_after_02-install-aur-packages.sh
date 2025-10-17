#!/bin/bash

set -euo pipefail

declare -r PKGLIST=$HOME/.pkglist
declare -r PKG_AUR=$PKGLIST/aur
declare -r PKGLOG="/tmp/install-aur-packages_$(date +%Y%m%d_%H%M%S).log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$PKGLOG"
}

error() {
  log "ERROR: $*" >&2
}

echo ">> Installing AUR packages..."

########################################################
# Validation
########################################################

if [[ ! -f "$PKG_AUR" ]]; then
  error "AUR package list not found at $PKG_AUR"
  exit 1
fi

if ! command -v yay &>/dev/null; then
  error "yay not found - installing yay first..."
  sudo pacman -S yay --needed --noconfirm
fi

########################################################
# AUR packages
########################################################

log "Starting AUR package installation..."
failed_packages=()
successful_packages=()

while IFS= read -r pkg || [[ -n "$pkg" ]]; do
  [[ -z "$pkg" || "$pkg" =~ ^#.*$ ]] && continue

  log "Processing AUR package: $pkg"

  if yay -Qs "^$pkg$" &>/dev/null; then
    log "$pkg is already installed."
    continue
  fi

  log "Installing $pkg..."
  if yay -S --needed --noconfirm "$pkg"; then
    log "$pkg installed successfully"
    successful_packages+=("$pkg")
  else
    error "$pkg installation failed"
    failed_packages+=("$pkg")
  fi
done <"$PKG_AUR"

########################################################
# Summary
########################################################

log "AUR installation complete!"
log "Successfully installed: ${#successful_packages[@]} packages"
log "Failed installations: ${#failed_packages[@]} packages"

if [[ ${#failed_packages[@]} -gt 0 ]]; then
  error "Failed AUR packages: ${failed_packages[*]}"
  log "Check log file: $PKGLOG"
fi
