#!/bin/bash

HOSTNAME=$(hostname)

echo ">> Enabling systemd services..."

# enable systemd user services
systemctl --user daemon-reload
systemctl --user --now enable redshift
systemctl --user --now enable gopls
systemctl --user --now enable headroom

if [[ "$HOSTNAME" == "moochacho" ]]; then
  sudo systemctl enable memreserver.service
fi

if [[ "$HOSTNAME" == "bmo" ]]; then
  sudo systemctl enable ath11k-resume.service
fi
