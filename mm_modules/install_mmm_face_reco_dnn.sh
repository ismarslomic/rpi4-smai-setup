#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# see https://github.com/nischi/MMM-Face-Reco-DNN
function main() {
  e_header "Installing Magic Mirror module: MMM-Face-Reco-DNN"

  git clone https://github.com/nischi/MMM-Face-Reco-DNN.git ~/MagicMirror/modules/MMM-Face-Reco-DNN
  (cd ~/MagicMirror/modules/MMM-Face-Reco-DNN && npm install)

  e_success "Installing MMM-Face-Reco-DNN module completed"
}

main
