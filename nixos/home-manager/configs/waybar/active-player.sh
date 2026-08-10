#!/usr/bin/env bash

PLAYER=$(playerctl -p spotify,strawberry,mpv,firefox,%any metadata -f '{{playerName}}' 2>/dev/null)

case "$PLAYER" in
  *spotify*)
    ICON="spotify"
    ;;
  *firefox*)
    ICON="firefox"
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

METADATA=$(playerctl -p spotify,strawberry,mpv,firefox,%any metadata -f '{{ artist }} ~ {{ title }}' 2>/dev/null)

notify-send -i "$ICON" "Active Player: ${PLAYER^}" "$METADATA"
