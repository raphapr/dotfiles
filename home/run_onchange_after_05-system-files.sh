#!/bin/bash
# Deploy system-level files that live outside $HOME

HOSTNAME=$(hostname)

########################################################
# zram-generator config
########################################################

# {{ include "dot_config/system/zram-generator.conf" | sha256sum }}
echo ">> Deploying zram-generator config..."
sudo cp ~/.config/system/zram-generator.conf /etc/systemd/zram-generator.conf
sudo chmod 644 /etc/systemd/zram-generator.conf

########################################################
# aftersleep script
########################################################

if [[ "$HOSTNAME" == "moochacho" ]]; then
  sudo install -Dm755 "${HOME}"/.config/systemd/scripts/aftersleep.sh /usr/lib/systemd/system-sleep/aftersleep
fi

########################################################
# copy home udev rules to /etc/udev/rules.d
########################################################

if compgen -G "${HOME}/.config/udev/rules.d/*.rules" >/dev/null 2>&1; then
  sudo cp "${HOME}"/.config/udev/rules.d/*.rules /etc/udev/rules.d/
  sudo mkinitcpio -P
  echo "Udev rules copied and initramfs rebuilt"
else
  echo "Warning: no udev rules found, skipping"
fi
