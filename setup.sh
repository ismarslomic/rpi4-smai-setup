#!/bin/bash
# e: Exit immediately if a command returns a non-zero status
# u: Treat unset variables as an error when substituting.
# o pipefail: return value of a pipeline is the value of the last (rightmost) command
set -euo pipefail

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR/log_util/log.sh"

trap e_onScriptFailed 1 2 3 15 ERR

function upgrade() {
  e_note "Upgrading packages in Rpi"

  sudo apt-get update
  sudo apt-get upgrade -y

  e_success "Package upgrade completed"
}

function cleanUp() {
  e_note "Cleaning packages in Rpi"

  sudo apt-get clean

  e_success "Cleaning packages completed"
}

function main() {
  e_header "Starting Smart Mirror AI setup of your Raspberry Pi 4"

  # Read required input from user
  e_note "Before we start, we need some input from you"
  read -p "WiFi name (SSID): " wifi_ssid
  read -p "WiFi password: " wifi_passphrase

  read -p "OS locale (default: 'nb_NO.UTF-8', first field in /usr/share/i18n/SUPPORTED): " os_locale
  os_locale="${os_locale:="nb_NO.UTF-8"}"

  read -p "Keyboard layout (default: 'no', first field in /usr/share/X11/xkb/symbols/): " keyboard_layout
  keyboard_layout="${keyboard_layout:="no"}"

  read -p "Timezone (default: 'Europe/Oslo', see https://en.wikipedia.org/wiki/List_of_tz_database_time_zones): " timezone
  timezone="${timezone:="Europe/Oslo"}"

  read -p "MagicMirror language (default: 'nb', see https://github.com/MichMich/MagicMirror/tree/master/translations): " mm_language
  mm_language="${mm_language:="nb"}"

  read -p "OpenWeather location (default: 'Oslo,Norway', city and ISO 3166 country code): " ow_location
  ow_location="${ow_location:="Oslo,Norway"}"

  read -p "OpenWeather API key (create one at https://home.openweathermap.org/api_keys): " ow_api_key
  ow_api_key="${ow_api_key:=""}"

  e_success "That's all we need, thanks!"

  upgrade

  # Rpi config
  bash "$DIR"/ssh/enable_ssh.sh
  bash "$DIR"/boot_splash/disable_boot_splash.sh
  bash "$DIR"/boot_behaviour/set_desktop_auto_login.sh
  bash "$DIR"/wifi/configure_wifi.sh "$wifi_ssid" "$wifi_passphrase"
  bash "$DIR"/camera/enable_rpi_camera.sh
  bash "$DIR"/locale/change_locale.sh "$os_locale" "$keyboard_layout"
  bash "$DIR"/timezone/change_timezone.sh "$timezone"
  bash "$DIR"/screen_blanking/disable_screen_blanking.sh

  # CLI tools
  bash "$DIR"/bash_aliases/copy_bash_aliases.sh
  bash "$DIR"/useful_tools/useful_tools.sh

  # Smart Mirror
  bash "$DIR"/mm/node.sh
  bash "$DIR"/mm/magic_mirror.sh
  bash "$DIR"/mm/create_custom_css.sh
  bash "$DIR"/mm_modules/install_mmm_smart_touch.sh
  bash "$DIR"/mm_modules/install_mmm_face_reco_dnn_deps.sh
  bash "$DIR"/mm_modules/install_mmm_face_reco_dnn.sh
  bash "$DIR"/mm_modules/install_mmm-face-multi-user-recognition-smai.sh
  bash "$DIR"/pm2/pm2.sh
  bash "$DIR"/mm/copy_mm_config.sh "$mm_language" "$ow_location" "$ow_api_key"

  cleanUp

  e_success "Setup completed, we need to take a quick reboot"
  read -p "Press any key to continue..."

  sudo reboot
}

main
