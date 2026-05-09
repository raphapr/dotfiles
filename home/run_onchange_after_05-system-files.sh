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

if [[ "$HOSTNAME" == "bmo" ]]; then
  # ath11k must be unloaded before sleep; the legacy hook restarted NetworkManager too early.
  sudo rm -f /usr/lib/systemd/system-sleep/aftersleep
else
  sudo install -Dm755 "${HOME}"/.config/systemd/scripts/aftersleep.sh /usr/lib/systemd/system-sleep/aftersleep
fi

########################################################
# ath11k suspend/resume services
########################################################

# {{ include "dot_config/systemd/system/ath11k-suspend.service" | sha256sum }}
# {{ include "dot_config/systemd/system/ath11k-resume.service" | sha256sum }}
if [[ "$HOSTNAME" == "bmo" ]]; then
  echo ">> Deploying ath11k suspend/resume services..."
  sudo install -Dm644 "${HOME}"/.config/systemd/system/ath11k-suspend.service /etc/systemd/system/ath11k-suspend.service
  sudo install -Dm644 "${HOME}"/.config/systemd/system/ath11k-resume.service /etc/systemd/system/ath11k-resume.service
  sudo systemctl daemon-reload
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
