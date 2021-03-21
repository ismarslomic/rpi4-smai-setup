#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# see https://github.com/MichMich/MagicMirror/wiki/Auto-Starting-MagicMirror
function main() {
  e_header "Installing PM2 for automatic start of Magic Mirror"

  sudo npm install -g pm2
  sudo env PATH="$PATH":/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi
  cp "$DIR"/mm.sh ~/mm.sh
  pm2 start ~/mm.sh
  pm2 save
  pm2 stop mm

  e_success "Installing PM2 completed"
}

main
