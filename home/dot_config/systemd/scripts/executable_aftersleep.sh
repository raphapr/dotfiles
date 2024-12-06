#!/bin/bash

if [ "$1" = "pre" ]; then
  # Check if r8168 module is loaded
  if lsmod | grep -q "^r8168 "; then
    # Disable and enable the module
    modprobe -r r8168
    modprobe r8168
    echo "r8168 module has been disabled and enabled."
  else
    echo "r8168 module is not loaded, skipping disabling and enabling steps."
  fi

  # Ensure network adapter is working
  systemctl restart NetworkManager

  # Check if ZSA Technology exists in lsusb
  if lsusb | grep -q "ZSA Technology"; then
    # Find ErgoDox EZ keyboard's USB path
    ergoez_path=$(lsusb | awk '/ZSA Technology/{print $2"/"$4}')
    usbreset "/dev/bus/usb/$ergoez_path"
  else
    echo "ZSA Technology not found in lsusb, skipping USB reset."
  fi
fi
