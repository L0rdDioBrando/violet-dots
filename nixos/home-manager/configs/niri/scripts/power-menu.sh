#!/usr/bin/env bash

set -e

options="shutdown\0icon\x1fsystem-shutdown-symbolic\nreboot\0icon\x1fsystem-reboot-symbolic"

echo -e "$options" | rofi -dmenu -markup-rows -theme-str "
  window {
    height: 159px;
    width: 325px;
  }
  element selected.normal {
    background-color: #363a4f;
    color: #cad3f5;
  }
"
