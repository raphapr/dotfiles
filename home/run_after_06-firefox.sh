#!/bin/bash
# Runs on every apply: the profile only exists after Firefox's first launch.

set -euo pipefail

readonly FIREFOX_DIR="${HOME}/.config/mozilla/firefox"

# Firefox keeps using the legacy ~/.mozilla root when it exists.
root="${HOME}/.mozilla/firefox"
[[ -f "$root/installs.ini" ]] || root="$FIREFOX_DIR"

profile_name="$(sed -n 's/^Default=//p' "$root/installs.ini" 2>/dev/null | head -n1)"
profile="$root/$profile_name"

if [[ -z "$profile_name" || ! -d "$profile" ]]; then
  echo "No Firefox default profile under $root; skipping user.js and userChrome.css."
  exit 0
fi

mkdir -p "$profile/chrome"
ln -sf "$FIREFOX_DIR/user.js" "$profile/user.js"
ln -sf "$FIREFOX_DIR/userChrome.css" "$profile/chrome/userChrome.css"
