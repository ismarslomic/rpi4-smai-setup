#!/bin/bash

function main() {
  if xrandr -display :0 --listactivemonitors | grep -q "HDMI-1"; then
    echo 0 # enabled
    exit 0
  else
    echo -1 # disabled
    exit 0
  fi
}

main
