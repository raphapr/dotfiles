#!/bin/bash

set -euo pipefail

declare -r PKGLIST=$HOME/.pkglist
declare -r HOSTNAME=$(hostname)
declare -r PKGLOG="/tmp/install-aur-packages_$(date +%Y%m%d_%H%M%S).log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$PKGLOG"
}

error() {
  log "ERROR: $*" >&2
}

install_aur_packages_from_file() {
  local pkg_file="$1"
  local description="$2"

  if [[ ! -f "$pkg_file" ]]; then
    log "Package list not found at $pkg_file, skipping $description"
    return 0
  fi

  log "Installing $description from $pkg_file..."

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
  done <"$pkg_file"
}

echo ">> Installing AUR packages for hostname: $HOSTNAME"

########################################################
# Validation
########################################################

if ! command -v yay &>/dev/null; then
  error "yay not found - installing yay first..."
  sudo pacman -S yay --needed --noconfirm
fi

########################################################
# AUR package installation
########################################################

failed_packages=()
successful_packages=()

# Install AUR packages for all hosts
install_aur_packages_from_file "$PKGLIST/aur/packages" "AUR packages"

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
