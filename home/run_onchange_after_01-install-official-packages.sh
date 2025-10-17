#!/bin/bash

set -euo pipefail

declare -r PKGLIST=$HOME/.pkglist
declare -r HOSTNAME=$(hostname)
declare -r PKGLOG="/tmp/install-official-packages_$(date +%Y%m%d_%H%M%S).log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$PKGLOG"
}

error() {
  log "ERROR: $*" >&2
}

install_packages_from_file() {
  local pkg_file="$1"
  local description="$2"

  if [[ ! -f "$pkg_file" ]]; then
    log "Package list not found at $pkg_file, skipping $description"
    return 0
  fi

  log "Installing $description from $pkg_file..."

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
  done <"$pkg_file"
}

echo ">> Installing official packages for hostname: $HOSTNAME"

########################################################
# Package installation
########################################################

failed_packages=()
successful_packages=()

# Install common packages for all hosts
install_packages_from_file "$PKGLIST/official/common" "common packages"

# Install hostname-specific packages
case "$HOSTNAME" in
"bmo")
  install_packages_from_file "$PKGLIST/official/bmo" "bmo-specific packages"
  ;;
"moochacho")
  install_packages_from_file "$PKGLIST/official/moochacho" "moochacho-specific packages"
  ;;
*)
  log "Unknown hostname: $HOSTNAME, installing common packages only"
  ;;
esac

########################################################
# Summary
########################################################

log "Official package installation complete!"
log "Successfully installed: ${#successful_packages[@]} packages"
log "Failed installations: ${#failed_packages[@]} packages"

if [[ ${#failed_packages[@]} -gt 0 ]]; then
  error "Failed packages: ${failed_packages[*]}"
  log "Check log file: $PKGLOG"
  exit 1
fi
