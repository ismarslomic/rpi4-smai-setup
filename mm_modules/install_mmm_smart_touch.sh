#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function main() {
  e_header "Installing Magic Mirror module: MMM-SmartTouch"

  git clone https://github.com/EbenKouao/MMM-SmartTouch.git ~/MagicMirror/modules/MMM-SmartTouch
  (cd ~/MagicMirror/modules/MMM-SmartTouch && npm install)

  e_success "Installing MMM-SmartTouch module completed"
}

main
