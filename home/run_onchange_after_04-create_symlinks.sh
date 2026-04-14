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

if [ ! -d ~/.local/share/ptpython ]; then
  mkdir -p ~/.local/share/ptpython
fi

if [ ! -f ~/.local/share/ptpython/history ]; then
  ln -sf ~/Cloud/Sync/ptpython_history ~/.local/share/ptpython/history
fi

if [ ! -d ~/.config/opencode ]; then
  ln -sf ~/Cloud/Sync/opencode ~/.config/opencode
fi

if [ ! -d ~/.opencode-mem/data ]; then
  ln -sf ~/Cloud/Sync/opencode-mem/data ~/.opencode-mem/data
fi
