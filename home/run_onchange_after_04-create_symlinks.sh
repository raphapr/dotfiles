#!/bin/bash

echo ">> Creating symlinks..."

########################################################
# sensitive files
########################################################

ln -sf ~/Dropbox ~/Cloud
ln -sf ~/Cloud/Sync/envsen ~/.envsen
ln -sf ~/Cloud/Sync/ssh_config ~/.ssh/config
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
