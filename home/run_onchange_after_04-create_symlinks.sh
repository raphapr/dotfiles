#!/bin/bash

echo ">> Creating symlinks..."

########################################################
# sensitive files
########################################################

if [ ! -d ~/Cloud ]; then
  ln -sf ~/Dropbox ~/Cloud
fi

if [ ! -d ~/.krew ]; then
  ln -sf ~/Cloud/Sync/krew ~/.krew
fi

if [ ! -d ~/.config/opencode ]; then
  ln -sf ~/Cloud/Sync/opencode ~/.config/opencode
fi

if [ ! -d ~/.omniroute ]; then
  ln -sf ~/Cloud/Sync/omniroute ~/.omniroute
fi
