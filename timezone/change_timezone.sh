#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Timezone changed by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function displayUsage() {
  echo "This script must be run with 1 argument"
  echo -e "\nUsage: $0 [Timezone]\n"
}

function main() {
  e_header "Changing timezone in Rpi OS"

  if [ $# -ne 1 ]; then
    displayUsage
    exit 1
  fi

  timezone="$1"
  sudo raspi-config nonint do_change_timezone "$timezone"

  e_note "Timezone changed to: '$timezone'"
  e_success "Changing timezone in Rpi OS completed"
}

main "$@"
