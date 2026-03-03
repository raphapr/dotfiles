#!/bin/sh

PLAYER="spotify"
MAX_LENGTH=60

# Single playerctl call for all metadata
OUTPUT=$(playerctl -p "$PLAYER" metadata --format "{{ status }}|{{ volume }}|{{ artist }}: {{ title }}" 2>/dev/null)

STATUS=$(echo "$OUTPUT" | cut -d'|' -f1)
VOLUME=$(echo "$OUTPUT" | cut -d'|' -f2)
CURRENT_TRACK=$(echo "$OUTPUT" | cut -d'|' -f3)

[ "$STATUS" = "Playing" ] && STATUS_ICON=$(printf '\uf04b') || STATUS_ICON=$(printf '\uf04c')
[ "$VOLUME" = "0.0" ] && VOLUME_ICON=$(printf '\uf026') || VOLUME_ICON=$(printf '\uf028')

if [ ${#CURRENT_TRACK} -gt $MAX_LENGTH ]; then
    CURRENT_TRACK="${CURRENT_TRACK:0:$MAX_LENGTH}..."
fi

echo "${CURRENT_TRACK} $STATUS_ICON $VOLUME_ICON"
