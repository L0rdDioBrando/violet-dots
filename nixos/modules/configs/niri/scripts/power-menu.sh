#!/usr/bin/env bash

shutdown=""
reboot="󰑓"
lock=""

options="$lock\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -no-config -dmenu -i -p "Power" -show-icons \
  -theme-str '
    * {
      background-color: transparent;
    }

    window {
      width: 574px;
      border-radius: 10px;
      border: 2px;
      border-color: #b7bdf8;
      background-color: #24273a;
    }

    inputbar { enabled: false; }

    listview {
      layout: horizontal;
      spacing: 40px;
    }

    element {
      padding: 20px;
      width: 150px;
      background-color: #24273a;
      text-color: #cad3f5; 
    }

    element-text {
      font: "FiraCode Nerd Font Mono 100";
    }

    element alternate.normal {
      background-color: #24273a;
      text-color: #cad3f5;
    }

    element normal.normal {
      background-color: #24273a;
      text-color: #cad3f5;
    }

   element selected.normal {
      background-color: #24273a;
      text-color: #b7bdf8;
    }

    element selected.active {
      text-color: #b7bdf8;
      background-color: #24273a;
    }
')"

case $chosen in
  "$shutdown")
    systemctl poweroff ;;
  "$reboot")
    systemctl reboot ;;
  "$lock")
    hyprlock -c ~/.config/niri/hyprlock.conf ;;
esac
