#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/niri/wallpapers"

cd "$WALLPAPER_DIR" || exit
options=$(find . -maxdepth 1 -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) | sed 's|^\./||' | sort)

chosen=$(
  for file in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
    [ -f "$file" ] || continue 
        
    filename=$(basename "$file")
        
    echo -en "${filename}\0icon\x1f${file}\n"
  done | rofi -dmenu -i -show-icons -p "  Wallpapers" -theme-str '
    window {
      width: 1200px;
      background-color: #24273a;
      border: 2px;
      border-color: #b7bdf8;
      border-radius: 12px;
      padding: 20px;
    }

    listview {
      layout: horizontal;
      spacing: 20px;
      lines: 5;
      columns: 1;
    }

    element {
      orientation: vertical;
      padding: 15px;
      border-radius: 10px;
      background-color: #363a4f;
    }

    element selected {
      background-color: #b7bdf8;
      text-color: #24273a;
    }

    element-icon {
      size: 200px;
      cursor: pointer;
    }

    element-text {
      horizontal-align: 0.5;
      vertical-align: 0.5;
      margin: 10px 0 0 0;
      text-color: inherit;
    }
  '
)

if [ -z "$chosen" ]; then
  exit 0
fi

WALLPAPER_PATH="$WALLPAPER_DIR/$chosen"

awww img "$WALLPAPER_PATH" --transition-type left --transition-step 3 --transition-fps 180

notify-send "Wallpaper update" "$chosen"
