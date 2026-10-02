#!/bin/bash
# Runs on every apply: the profile only exists after Firefox's first launch.

set -euo pipefail
shopt -s nullglob

readonly FIREFOX_DIR="${HOME}/.config/mozilla/firefox"
profiles=("$FIREFOX_DIR"/*.default-release)

if [[ ${#profiles[@]} -eq 0 ]]; then
  echo "No Firefox default-release profile; skipping user.js and userChrome.css."
  exit 0
fi

profile="${profiles[0]}"
mkdir -p "$profile/chrome"
ln -sf "$FIREFOX_DIR/user.js" "$profile/user.js"
ln -sf "$FIREFOX_DIR/userChrome.css" "$profile/chrome/userChrome.css"
