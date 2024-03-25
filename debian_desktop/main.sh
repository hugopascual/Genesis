#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$BASE_DIR/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$BASE_DIR/utils/installations.sh"
# shellcheck source=/dev/null
source "$BASE_DIR/utils/dit.sh"

#------------------------------- Start
echo_info "Starting installation"

#------------------------------- Update and Upgrade
"$BASE_DIR"/scripts/update_system.sh

#------------------------------- Custom installations
install_flatpak
install_VScode
install_docker
install_jetbrains_toolbox
install_lutris

#------------------------------- Ubuntu repository installs
apt_get_install "Basic utilities" "wget curl net-tools"
apt_get_install "Git" "git"
apt_get_install "Java JRE" "default-jre"
apt_get_install "Java JDK" "default-jdk"
apt_get_install "Firefox" "firefox-esr"
apt_get_install "Teminator" "terminator"
apt_get_install "GNU Image Manipulation Program" "gimp"
apt_get_install "Raspberry Pi OS Imager" "rpi-imager"

#------------------------------- Flatpak installs
flathub_install "VLC" "org.videolan.VLC"
flathub_install "Thunderbird" "org.mozilla.Thunderbird"
flathub_install "Spotify" "com.spotify.client"
flathub_install "Google Chrome" "com.google.Chrome"
flathub_install "KeePassXC" "org.keepassxc.KeePassXC"
flathub_install "Wireshark" "org.wireshark.Wireshark"
flathub_install "Postman" "com.getpostman.Postman"
flathub_install "Telegram" "org.telegram.desktop"
flathub_install "Steam" "com.valvesoftware.Steam"

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
"$BASE_DIR"/scripts/desktop_config.sh
"$BASE_DIR"/scripts/git_config.sh

#------------------------------- Updates and Cleaning 
"$BASE_DIR"/scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
