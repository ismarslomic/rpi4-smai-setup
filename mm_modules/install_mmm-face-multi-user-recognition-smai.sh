#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function main() {
  e_header "Installing Magic Mirror module: MMM-Face-Multi-User-Recognition-SMAI"

  git clone https://github.com/ismarslomic/MMM-Face-Multi-User-Recognition-SMAI ~/MagicMirror/modules/MMM-Face-Multi-User-Recognition-SMAI
  (cd ~/MagicMirror/modules/MMM-Face-Multi-User-Recognition-SMAI && npm install)

  e_success "Installing MMM-Face-Multi-User-Recognition-SMAI completed"
}

main
