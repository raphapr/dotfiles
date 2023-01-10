#!/bin/bash

echo
echo 'updates.sh: "yay -Syu"'
echo
yay -Syu

echo
bash ~/.config/polybar/scripts/checkupdates.sh

read -p "Press enter to close this window..."
