#!/usr/bin/env bash

set -e

options="shutdown\0icon\x1f<span foreground='#cad3f5'>\Uf0425</span>\nreboot\0icon\x1f<span foreground='#cad3f5'>\Uf0709</span>\nlock\0icon\x1f<span foreground='#cad3f5'>\Uf033e</span>"

chosen=$(echo -e "$options" | rofi -dmenu -markup-rows -theme-str "
  window {
    height: 200px;
    width: 325px;
  }
  element selected.normal {
    background-color: #363a4f;
    color: #cad3f5;
  }
")

case "$chosen" in
  "shutdown")
    poweroff & 
    ;;
  "reboot")
    reboot &
    ;;
  "lock")
    hyprlock -c ~/.config/niri/hyprlock.conf &
    ;;
esac
