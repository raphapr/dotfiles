#!/bin/bash

HOSTNAME=$(hostname)

echo ">> Enabling systemd services..."

# enable systemd user services
systemctl --user daemon-reload
systemctl --user --now enable psd
systemctl --user --now enable redshift
ez
if [[ "$HOSTNAME" == "moochacho" ]]; then
  sudo systemctl enable memreserver.service
fi
