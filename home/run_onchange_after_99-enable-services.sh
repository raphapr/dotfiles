#!/bin/bash

echo ">> Enabling systemd services..."

# enable systemd user services
systemctl --user daemon-reload
systemctl --user --now enable psd
systemctl --user --now enable gopls
systemctl --user --now enable redshift
systemctl --user --now enable syncthing
