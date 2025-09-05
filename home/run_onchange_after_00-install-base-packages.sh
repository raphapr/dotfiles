#!/bin/bash

# Update the system
echo ">> Installing base packages..."
sudo pacman -Syu --needed

# Define log file for failed installations
PKGLOG="/tmp/package_install_$(date +%Y%m%d_%H%M%S).log"
mkdir -p "$(dirname "$PKGLOG")"

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
    echo "Installing $pkg..."
    if sudo pacman -S --noconfirm --needed "$pkg"; then
      echo "$pkg installed successfully"
    else
      echo "$pkg installation failed" | tee -a "$PKGLOG"
    fi
  else
    echo "$pkg is already installed."
  fi
done

# Report any failures
if [ -f "$PKGLOG" ] && [ -s "$PKGLOG" ]; then
  echo ""
  echo "Some packages failed to install. Check log: $PKGLOG"
else
  echo ""
  echo "All packages installed successfully!"
fi
