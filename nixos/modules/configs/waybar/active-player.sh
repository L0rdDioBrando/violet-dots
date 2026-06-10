#!/usr/bin/env bash

PLAYER=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata -f '{{playerName}}' 2>/dev/null)

if [ -z "$PLAYER" ]; then
  notify-send -i dialog-error "Active Player" "No active players"
  exit 1
fi

case "$PLAYER" in
  *spotify*)
    ICON="spotify"
    ;;
  *firefox*)
    ICON="firefox"
    ;;
  *vlc*)
    ICON="vlc"
    ;;
  *mpv*)
    ICON="mpv"
    ;;
  *strawberry*)
    ICON="strawberry"
    ;;
  *)
    ICON="audio-player"
    ;;
esac

METADATA=$(playerctl -p spotify,strawberry,firefox,mpv,%any metadata -f '{{ artist }} ~ {{ title }}' 2>/dev/null)

notify-send -i "$ICON" "Active Player: ${PLAYER^}" "$METADATA"
