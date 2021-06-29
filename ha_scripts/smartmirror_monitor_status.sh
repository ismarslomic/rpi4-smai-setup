#!/bin/bash

function main() {
  STATUS="$(vcgencmd display_power | tail -c 2 | head -c 1)"

  if [ "${STATUS}" = 1 ]; then
    echo 0
    exit 0
  else
    echo -1
    exit 0
  fi
}

main
