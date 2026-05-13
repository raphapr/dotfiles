#!/usr/bin/env bash
set -euo pipefail

# tms (tmux-sessionizer) owns its config.toml because it writes marks at
# runtime. Seed search paths and default session here so new machines get a
# usable config without versioning the file (which leaks personal marks).
command -v tms >/dev/null || exit 0

tms config \
  --session raphael \
  --paths "~/repos" "~/.local/share/chezmoi" "~/.pi" \
  --max-depths 10 10 10

# Bookmark non-git directories so they show up in the picker alongside repos.
tms bookmark ~ >/dev/null 2>&1 || true
