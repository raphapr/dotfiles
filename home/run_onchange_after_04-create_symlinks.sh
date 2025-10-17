#!/bin/bash

echo ">> Creating symlinks..."

########################################################
# sensitive files
########################################################

ln -sf ~/Dropbox ~/Cloud
ln -sf ~/Cloud/Sync/krew ~/.krew
ln -sf ~/Cloud/Sync/ptpython_history ~/.local/share/ptpython/history

########################################################
# aftersleep script
########################################################

sudo cp "${HOME}"/.config/systemd/scripts/aftersleep.sh /usr/lib/systemd/system-sleep/aftersleep
sudo chown root: /usr/lib/systemd/system-sleep/aftersleep

########################################################
# copy home udev rules to /etc/udev/rules.d
########################################################

sudo cp "${HOME}"/.config/udev/rules.d/*.rules /etc/udev/rules.d/
sudo mkinitcpio -P
echo "Udev rules copied and initramfs rebuilt"
echo "Warning: no udev rules found"

########################################################
# firefox user.js
########################################################

if [ -d "${HOME}"/.mozilla/firefox ]; then
  FIREFOX_PROFILE_DIR=$(find "${HOME}"/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)
  if [ -n "$FIREFOX_PROFILE_DIR" ]; then
    ln -sf ~/.mozilla/firefox/user.js "$FIREFOX_PROFILE_DIR/user.js"
    echo "Firefox user.js symlink created in $FIREFOX_PROFILE_DIR"
  else
    echo "No Firefox default-release profile found."
  fi
else
  echo "Firefox directory not found."
fi
