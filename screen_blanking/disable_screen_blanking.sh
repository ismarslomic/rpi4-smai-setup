#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Screen blanking disabled by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function main() {
  e_header "Disabling screen blanking"

  # 0 = enabled, 1 = disabled
  sudo raspi-config nonint do_blanking 1

  e_success "Disabling screen blanking completed"
}

main
