#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

INSTALLATIONS_FILEPATH="$DIRECTORY/utils/installations.sh"
# shellcheck source=/dev/null
source "$INSTALLATIONS_FILEPATH"

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

DIT_FILEPATH="$DIRECTORY/utils/dit.sh"
# shellcheck source=/dev/null
source "$DIT_FILEPATH"

echo_info "Starting installation"

#------------------------------- Update and Upgrade
./"$DIRECTORY"/scripts/update_system.sh

#------------------------------- Custom installations
install_flatpak
install_VScode
install_nodejs
install_docker
install_jetbrains_toolbox
install_lutris

#------------------------------- Ubuntu repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"
apt_get_install "Firefox" "firefox"
apt_get_install "Teminator" "terminator"
apt_get_install "GNU Image Manipulation Program" "gimp"
apt_get_install "Raspberry Pi OS Imager" "rpi-imager"

#------------------------------- Snap installs

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
./"$DIRECTORY"/scripts/desktop_config.sh
./"$DIRECTORY"/scripts/git_config.sh

#------------------------------- Updates and Cleaning 
./"$DIRECTORY"/scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
