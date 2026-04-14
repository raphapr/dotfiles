#!/bin/bash

########################################################
# firefox user.js
########################################################

if [ -d "${HOME}"/.mozilla/firefox ]; then
  FIREFOX_PROFILE_DIR=$(find "${HOME}"/.mozilla/firefox -maxdepth 1 -name "*.default-release" | head -n 1)
  if [ -n "$FIREFOX_PROFILE_DIR" ]; then
    ln -sf ~/.mozilla/firefox/user.js "$FIREFOX_PROFILE_DIR/user.js"
    echo "Firefox user.js symlink created in $FIREFOX_PROFILE_DIR"
    if [ ! -d "$FIREFOX_PROFILE_DIR/chrome" ]; then
      mkdir "$FIREFOX_PROFILE_DIR/chrome"
    fi
    ln -sf ~/.mozilla/firefox/userChrome.css "$FIREFOX_PROFILE_DIR/chrome/userChrome.css"
    echo "Firefox userChrome.css symlink created in $FIREFOX_PROFILE_DIR/chrome"
  else
    echo "No Firefox default-release profile found."
  fi
else
  echo "Firefox directory not found."
fi
