#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Camera enabled by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function main() {
  e_header "Enabling Rpi 4 Camera Module"

  # 0 = enabled, 1 = disabled
  sudo raspi-config nonint do_camera 0

  e_success "Enabling Rpi 4 Camera completed"
}

main
