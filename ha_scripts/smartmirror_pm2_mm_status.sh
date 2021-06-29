#!/bin/bash

function main() {
  STATUS="$(pm2 jlist | jq '.[0].pm2_env.status' -r)"

  if [ "${STATUS}" = "online" ]; then
    echo 0
    exit 0
  else
    echo -1
    exit 0
  fi
}

main
