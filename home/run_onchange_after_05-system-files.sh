#!/bin/bash
# Deploy system-level files that live outside $HOME

# zram-generator config
# {{ include "dot_config/system/zram-generator.conf" | sha256sum }}
echo ">> Deploying zram-generator config..."
sudo cp ~/.config/system/zram-generator.conf /etc/systemd/zram-generator.conf
sudo chmod 644 /etc/systemd/zram-generator.conf

{{ if eq .chezmoi.hostname "moochacho" -}}
# amdgpu pre-sleep hook
# {{ include "dot_config/system/executable_amdgpu-vram-presleep" | sha256sum }}
echo ">> Deploying amdgpu suspend hook..."
sudo cp ~/.config/system/executable_amdgpu-vram-presleep \
  /usr/lib/systemd/system-sleep/amdgpu-vram-presleep
sudo chmod 755 /usr/lib/systemd/system-sleep/amdgpu-vram-presleep
{{ end -}}
