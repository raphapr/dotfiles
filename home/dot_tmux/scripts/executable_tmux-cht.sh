#!/usr/bin/env bash

CURRENT_DIR="/tmp"

if test -f "$CURRENT_DIR/cht.sh"; then
  CHTSH="$CURRENT_DIR/cht.sh"
else
  curl -Ss https://cht.sh/:cht.sh > "$CURRENT_DIR/cht.sh"
  chmod +x "$CURRENT_DIR/cht.sh"
  CHTSH="$CURRENT_DIR/cht.sh"
fi

if test -f "$CURRENT_DIR/list"; then
  LIST="$CURRENT_DIR/list"
else
  curl -Ss https://cht.sh/:list > "$CURRENT_DIR/list"
  LIST="$CURRENT_DIR/list"
fi

ITEM="$(cat "$LIST" | fzf --preview="bash $CHTSH {}" )"

if [ "$ITEM" == "" ]; then
  exit 0
fi

read -r -e -p "Query for $ITEM: " QUERY


if ! [ "$QUERY" == "" ]; then
  QUERY="$(printf "$%s" "$QUERY" | sed 's/\ /+/g')"
fi


bash "$CHTSH" "$ITEM" "$QUERY" | bat --paging always
