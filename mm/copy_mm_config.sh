#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function displayUsage() {
  echo "This script must be run with 3 argument"
  echo -e "\nUsage: $0 [MM timezone] [OpenWeather location (city,country code)] [OpenWeather API key]\n"
}

function main() {
  e_header "Copying Magic Mirror Configuration"

  if [ $# -ne 1 ]; then
    displayUsage
    exit 1
  fi

  export MM_LANGUAGE="$1"
  export OW_LOCATION="$2"
  export OW_API_KEY="$3"
  cat "$DIR"/config.template.js | envsubst >~/MagicMirror/config/config.js

  e_success "Copying Magic Mirror configuration completed"
}

main "$@"
