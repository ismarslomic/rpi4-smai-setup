#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/../log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

# Locale changed by using (undocumented) scripts of raspi-config command,
# see https://github.com/RPi-Distro/raspi-config/blob/master/raspi-config

function changeOsLocale() {
  # first field in /usr/share/i18n/SUPPORTED
  os_locale="$1"
  sudo raspi-config nonint do_change_locale "$os_locale"

  e_note "OS locale changed to: '$os_locale'"
}

function changeKeyboardLayout() {
  # directory in /usr/share/X11/xkb/symbols/
  keyboard_layout="$1"
  sudo raspi-config nonint do_configure_keyboard "$keyboard_layout"

  e_note "Keyboard layout changed to: '$keyboard_layout'"
}

function displayUsage() {
  echo "This script must be run with 2 arguments"
  echo -e "\nUsage: $0 [OS locale] [Keyboard layout] \n"
}

function main() {
  e_header "Changing OS locale and keyboard layout in Rpi"

  if [ $# -ne 2 ]; then
    displayUsage
    exit 1
  fi

  os_locale="$1"
  keyboard_layout="$2"

  changeOsLocale "$os_locale"
  changeKeyboardLayout "$keyboard_layout"

  e_success "Changing OS locale and keyboard layout completed"
}

main "$@"
