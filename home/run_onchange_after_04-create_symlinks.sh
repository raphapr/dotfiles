#!/bin/bash

echo ">> Creating symlinks..."

# sync sensitive, not versioned, dotfiles
ln -sf ~/Dropbox ~/Cloud
ln -sf ~/Cloud/sync/envsen ~/.envsen
ln -sf ~/Cloud/sync/ssh_config ~/.ssh/config
ln -sf ~/Cloud/sync/krew ~/.krew

if [ ! -d "${HOME}/.asdf" ]; then
  mkdir ~/.asdf
fi

if [ ! -d "${HOME}/.asdf/plugins" ]; then
  ln -sf ~/Cloud/sync/asdf-plugins ~/.asdf/plugins
fi

# aftersleep script
sudo cp "${HOME}"/.config/systemd/scripts/aftersleep.sh /usr/lib/systemd/system-sleep/aftersleep
sudo chown root: /usr/lib/systemd/system-sleep/aftersleep
