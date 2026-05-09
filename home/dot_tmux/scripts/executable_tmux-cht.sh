#!/usr/bin/env bash

set -euo pipefail

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/cht.sh"
LIST="$CACHE_DIR/list"
LIST_TTL_SECONDS=$((7 * 24 * 60 * 60))

mkdir -p "$CACHE_DIR"
chmod 700 "$CACHE_DIR"

fetch() {
  curl -fsSL --retry 2 --retry-delay 1 "$1"
}

refresh_list() {
  local tmp
  tmp="$(mktemp "$CACHE_DIR/list.XXXXXX")"
  if fetch "https://cht.sh/:list" | grep -E '^[A-Za-z0-9_.+-]+$' >"$tmp"; then
    mv "$tmp" "$LIST"
  else
    rm -f "$tmp"
    return 1
  fi
}

list_is_stale() {
  [[ ! -s "$LIST" ]] && return 0
  [[ $(($(date +%s) - $(stat -c %Y "$LIST"))) -gt $LIST_TTL_SECONDS ]]
}

preview_topic() {
  local topic="$1"
  [[ "$topic" =~ ^[A-Za-z0-9_.+-]+$ ]] || exit 0
  fetch "https://cht.sh/$topic" | sed -n '1,120p'
}

if [[ "${1:-}" == "--preview" ]]; then
  preview_topic "${2:-}"
  exit 0
fi

if list_is_stale; then
  refresh_list
fi

ITEM="$(fzf --preview="$0 --preview {}" <"$LIST")"

if [[ -z "$ITEM" ]]; then
  exit 0
fi

read -r -e -p "Query for $ITEM: " QUERY

if [[ -n "$QUERY" ]]; then
  QUERY="$(printf '%s' "$QUERY" | sed -E 's/[[:space:]]+/+/g')"
fi

fetch "https://cht.sh/$ITEM/$QUERY" | bat --paging always
