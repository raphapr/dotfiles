#!/bin/bash

set -euo pipefail

readonly COMPLETION_DIR="$HOME/.config/fish/completions"
mkdir -p "$COMPLETION_DIR"

# chezmoi may run without mise activated; shims expose mise-managed tools.
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Run "$@" into <command>.fish when the command exists; remove a stale file when it doesn't.
sync_completion() {
  local name="$1"

  if command -v "$name" >/dev/null 2>&1; then
    "$@" >"$COMPLETION_DIR/$name.fish"
  else
    rm -f "$COMPLETION_DIR/$name.fish"
  fi
}

if command -v aws_completer >/dev/null 2>&1; then
  cat >"$COMPLETION_DIR/aws.fish" <<'FISH'
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); command aws_completer | sed \'s/ $//\'; end)'
FISH
else
  rm -f "$COMPLETION_DIR/aws.fish"
fi

if command -v mise >/dev/null 2>&1 && command -v usage >/dev/null 2>&1; then
  mise completion fish >"$COMPLETION_DIR/mise.fish"
else
  rm -f "$COMPLETION_DIR/mise.fish"
fi

sync_completion tv completions fish
sync_completion atuin gen-completions --shell fish
sync_completion op completion fish
