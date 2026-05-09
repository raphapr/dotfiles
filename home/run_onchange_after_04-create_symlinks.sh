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
