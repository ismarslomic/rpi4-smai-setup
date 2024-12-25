#!/bin/bash

function main() {
  STATUS=$(wlr-randr | grep -A 2 "HDMI-A-1" | grep "Enabled" | awk '{print $2}')

  if [ "$STATUS" == "yes" ]; then
    echo 0 # enabled
    exit 0
  else
    echo -1 # disabled
    exit 0
  fi
}

main
