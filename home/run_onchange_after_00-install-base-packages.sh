#!/bin/bash

set -euo pipefail

declare -r PKGLIST=$HOME/.pkglist
declare -r PKG_BASE=$PKGLIST/base/packages
declare -r PKGLOG="/tmp/install-base-packages_$(date +%Y%m%d_%H%M%S).log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$PKGLOG"
}

error() {
  log "ERROR: $*" >&2
}

echo ">> Installing base packages..."

########################################################
# Update system first
########################################################
log "Updating system packages..."
sudo pacman -Syu --needed

########################################################
# Validation
########################################################

if [[ ! -f "$PKG_BASE" ]]; then
  error "Base package list not found at $PKG_BASE"
  exit 1
fi

########################################################
# pacman
########################################################

log "Starting base package installation..."
failed_packages=()
successful_packages=()

# Read packages, skip empty lines and comments
while IFS= read -r pkg || [[ -n "$pkg" ]]; do
  [[ -z "$pkg" || "$pkg" =~ ^#.*$ ]] && continue

  log "Processing package: $pkg"

  if pacman -Qs "^$pkg$" &>/dev/null; then
    log "$pkg is already installed."
    continue
  fi

  log "Installing $pkg..."
  if sudo pacman -S --needed --noconfirm "$pkg"; then
    log "$pkg installed successfully"
    successful_packages+=("$pkg")
  else
    error "$pkg installation failed"
    failed_packages+=("$pkg")
  fi
done <"$PKG_BASE"

########################################################
# Summary
########################################################

log "Base installation complete!"
log "Successfully installed: ${#successful_packages[@]} packages"
log "Failed installations: ${#failed_packages[@]} packages"

if [[ ${#failed_packages[@]} -gt 0 ]]; then
  error "Failed packages: ${failed_packages[*]}"
  log "Check log file: $PKGLOG"
  exit 1
fi
