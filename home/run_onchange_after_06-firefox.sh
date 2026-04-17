#!/bin/bash

########################################################
# firefox user.js
########################################################

FIREFOX_PROFILE_PATH="${HOME}/.config/mozilla/firefox"

if [ -d "${FIREFOX_PROFILE_PATH}" ]; then
  FIREFOX_PROFILE_DIR=$(find "${FIREFOX_PROFILE_PATH}" -maxdepth 1 -name "*.default-release" | head -n 1)
  if [ -n "$FIREFOX_PROFILE_DIR" ]; then
    ln -sf "${FIREFOX_PROFILE_PATH}/user.js" "$FIREFOX_PROFILE_DIR/user.js"
    echo "Firefox user.js symlink created in $FIREFOX_PROFILE_DIR"
    if [ ! -d "$FIREFOX_PROFILE_DIR/chrome" ]; then
      mkdir "$FIREFOX_PROFILE_DIR/chrome"
    fi
    ln -sf "${FIREFOX_PROFILE_PATH}"/userChrome.css "$FIREFOX_PROFILE_DIR/chrome/userChrome.css"
    echo "Firefox userChrome.css symlink created in $FIREFOX_PROFILE_DIR/chrome"
  else
    echo "No Firefox default-release profile found."
  fi
else
  echo "Firefox directory not found."
fi
