#!/bin/sh

status=$(bluetoothctl show 2>/dev/null)

if ! printf '%s\n' "$status" | grep -q 'Powered: yes'; then
  echo '󰂲'
elif connected=$(bluetoothctl devices Connected 2>/dev/null | grep -c '^Device '); [ "$connected" -gt 0 ]; then
  printf '󰂯 %%{T1}%s%%{T-}\n' "$connected"
else
  echo '󰂯'
fi
