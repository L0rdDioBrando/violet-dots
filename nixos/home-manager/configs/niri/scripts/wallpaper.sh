#!/usr/bin/env bash

set -e

DIR="$HOME/.config/niri/wallpapers"

options=""
for file in "$DIR"/*.{jpg,png}; do
  filename=$(basename "$file")
  options+="${filename}\0icon\x1f${file}\n"
done

chosen=$(echo -e "$options" | rofi -dmenu -theme-str "
  listview { 
    lines: 6; 
  }
  element-icon {
    size: 5ch;
  }
")

awww img "$DIR/$chosen" --transition-type left --transition-step 3 --transition-fps 180

notify-send "Wallpaper update" "$chosen"
