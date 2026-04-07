#!/bin/bash
# Deploy system-level files that live outside $HOME

# zram-generator config
# {{ include "dot_config/system/zram-generator.conf" | sha256sum }}
echo ">> Deploying zram-generator config..."
sudo cp ~/.config/system/zram-generator.conf /etc/systemd/zram-generator.conf
sudo chmod 644 /etc/systemd/zram-generator.conf
