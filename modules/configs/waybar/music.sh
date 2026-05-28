#!/usr/bin/env bash

playerctl -p spotify,strawberry,firefox,mpv,%any metadata --format \
'{"text": " {{markup_escape(artist)}} ~ {{markup_escape(title)}} ", "alt": "{{status}}", "class": "{{status}}", "album": "{{markup_escape(xesam:album)}}"}' -F 2>/dev/null | while read -r line; do
  [ -z "$line" ] && continue
  album=$(echo "$line" | jq -r '.album' 2>/dev/null)

  if [ "$album" = "null" ] || [ -z "$album" ]; then
    tooltip="Single / Unknown Album"
    else
    tooltip="<span color='#b7bdf8' weight='bold'>$album</span>"
  fi

  if ! echo "$line" | jq --unbuffered --compact-output --arg tt "$tooltip" '.tooltip = $tt' 2>/dev/null; then
    exit 1
  fi
done
