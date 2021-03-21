#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Setting boot to desktop and autologin pi user by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function main() {
  e_header "Setting boot to desktop and autologin"

  #B1 cli, B2 cli autologin, B3 desktop, B4 desktop autologin
  sudo raspi-config nonint do_boot_behaviour B4

  e_success "Setting boot to desktop and autologin completed"
}

main
