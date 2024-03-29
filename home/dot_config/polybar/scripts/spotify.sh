#!/bin/sh

PLAYER="spotify"
STATUS=$(playerctl -p "$PLAYER" status)
VOLUME=$(playerctl -p "$PLAYER" metadata --format "{{ volume }}")
CURRENT_TRACK=$(playerctl metadata -p "$PLAYER" --format "{{ artist }}: {{ title }}")
MAX_LENGTH=60

print_status() {
  if [ "$STATUS" = "Playing" ]; then
    STATUS=""
  else
    STATUS=""
  fi
  if [ "$VOLUME" = "0.0" ]; then
    VOLUME=""
  else
    VOLUME=""
  fi

  if [ ${#CURRENT_TRACK} -gt $MAX_LENGTH ]; then
    CURRENT_TRACK="${CURRENT_TRACK:0:$MAX_LENGTH}..."
  fi
  echo "${CURRENT_TRACK} $STATUS $VOLUME"
}

print_status
