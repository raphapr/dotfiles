#!/bin/bash
if ip link show tun0 &>/dev/null; then
  echo "󰒃  %{F#4DB6AC}ON%{F-}"
else
  echo "󰒃  %{F#FF5252}OFF%{F-}"
fi
