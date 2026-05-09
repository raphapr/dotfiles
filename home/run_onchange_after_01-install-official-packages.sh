#!/bin/bash

set -euo pipefail

declare -r PKGLIST=$HOME/.pkglist
HOSTNAME="$(hostname)"
readonly HOSTNAME
PKGLOG="/tmp/install-official-packages_$(date +%Y%m%d_%H%M%S).log"
readonly PKGLOG

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$PKGLOG"
}

error() {
  log "ERROR: $*" >&2
}

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

confirm_install "official packages for hostname: $HOSTNAME"

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
