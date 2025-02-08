#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function main() {
  LOCALE="en_US.UTF-8"
  LOCALE_GEN_FILE="/etc/locale.gen"

  e_header "Installing the locale $LOCALE"

  e_note "Checking if $LOCALE is enabled..."

  if ! grep -q "^$LOCALE UTF-8" "$LOCALE_GEN_FILE"; then
      e_note "Adding $LOCALE to $LOCALE_GEN_FILE..."
      echo "$LOCALE UTF-8" | sudo tee -a "$LOCALE_GEN_FILE" > /dev/null
  else
      e_note "$LOCALE is already enabled."
  fi

  e_note "Generating locales..."
  sudo locale-gen

  e_note "Locale updated! Current settings:"
  locale

  e_note "Done! Reboot or restart your session for changes to take effect."

  e_success "Installing the locale $LOCALE completed"
}

main
