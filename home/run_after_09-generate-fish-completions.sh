#!/bin/bash

set -euo pipefail

readonly COMPLETION_DIR="$HOME/.config/fish/completions"
mkdir -p "$COMPLETION_DIR"

if command -v aws_completer >/dev/null 2>&1; then
  cat > "$COMPLETION_DIR/aws.fish" <<'FISH'
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); command aws_completer | sed \'s/ $//\'; end)'
FISH
else
  rm -f "$COMPLETION_DIR/aws.fish"
fi

if command -v sesh >/dev/null 2>&1; then
  sesh completion fish > "$COMPLETION_DIR/sesh.fish"
fi

if command -v tv >/dev/null 2>&1; then
  tv completions fish > "$COMPLETION_DIR/tv.fish"
fi

if command -v mise >/dev/null 2>&1 && command -v usage >/dev/null 2>&1; then
  mise completion fish > "$COMPLETION_DIR/mise.fish"
else
  rm -f "$COMPLETION_DIR/mise.fish"
fi

if command -v atuin >/dev/null 2>&1; then
  atuin gen-completions --shell fish > "$COMPLETION_DIR/atuin.fish"
fi

if command -v op >/dev/null 2>&1; then
  op completion fish > "$COMPLETION_DIR/op.fish"
fi
