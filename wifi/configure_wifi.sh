#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Configuring Wifi by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function displayUsage() {
  echo "This script must be run with 2 arguments"
  echo -e "\nUsage: $0 [WiFi SSID] [WiFi passphrase] \n"
}

function main() {
  e_header "Configuring WiFi"

  if [ $# -ne 2 ]; then
    displayUsage
    exit 1
  fi

  ssid="$1"
  passphrase="$2"
  sudo raspi-config nonint do_wifi_ssid_passphrase $ssid $passphrase

  e_note "Configured wifi: '$ssid'"
  e_success "Configuring WiFi completed"
}

main "$@"
