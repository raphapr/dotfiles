#!/bin/bash

echo ">> Creating symlinks..."

# sync sensitive dotfiles
ln -sf ~/Dropbox ~/Cloud
ln -sf ~/Cloud/Sync/envsen ~/.envsen
ln -sf ~/Cloud/Sync/ssh_config ~/.ssh/config
ln -sf ~/Cloud/Sync/krew ~/.krew
ln -sf ~/Cloud/Sync/ptpython_history ~/.local/share/ptpython/history

if [ ! -d "${HOME}/.asdf" ]; then
  mkdir ~/.asdf
fi

if [ ! -d "${HOME}/.asdf/plugins" ]; then
  ln -sf ~/Cloud/Sync/asdf-plugins ~/.asdf/plugins
fi

# aftersleep script
sudo cp "${HOME}"/.config/systemd/scripts/aftersleep.sh /usr/lib/systemd/system-sleep/aftersleep
sudo chown root: /usr/lib/systemd/system-sleep/aftersleep

# userchrome.css
firefox_dir_path=$HOME/.mozilla/firefox
firefox_profiles_ini_path=$HOME/.mozilla/firefox/profiles.ini

if grep -q '\[Profile[^0]\]' "$firefox_profiles_ini_path"; then
  profile_path=$(grep -E '^\[Profile|^Path|^Default' "$firefox_profiles_ini_path" | grep -1 '^Default=1' | grep '^Path' | cut -c6-)
  userchrome_path="$firefox_dir_path/$profile_path/chrome"
  if [ ! -d "$userchrome_path" ]; then
    mkdir "$userchrome_path"
  fi
  ln -sf ~/Cloud/Sync/userChrome.css "$userchrome_path/userChrome.css"
fi
