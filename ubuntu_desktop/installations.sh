#!/bin/bash

DIRECTORY=$(dirname "$0")
FUNCTIONS_FILEPATH="$DIRECTORY/support_scripts/functions.sh"
# Import installing functions
# shellcheck source=/dev/null
source "$FUNCTIONS_FILEPATH"

#------------------------------- Configuration
./"$DIRECTORY"/support_scripts/config.sh

#------------------------------- Initialization
echo_info "Starting installation"

#------------------------------- Update and Upgrade
update

#------------------------------- Specific Software installations
install_flatpak
install_VScode
install_nodejs
install_docker
install_jetbrains_toolbox
install_lutris
install_openvpnc

#------------------------------- apt-get repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"
apt_get_install "Firefox" "firefox"
apt_get_install "Teminator" "terminator"
apt_get_install "GNU Image Manipulation Program" "gimp"

#------------------------------- Snap installs

#-------------------------------Flatpak installs
flathub_install "VLC" "org.videolan.VLC"
flathub_install "Thunderbird" "org.mozilla.Thunderbird"
flathub_install "Spotify" "com.spotify.client"
flathub_install "Google Chrome" "com.google.Chrome"
flathub_install "KeePassXC" "org.keepassxc.KeePassXC"
flathub_install "Wireshark" "org.wireshark.Wireshark"
flathub_install "Postman" "com.getpostman.Postman"
flathub_install "Telegram" "org.telegram.desktop"
flathub_install "Steam" "com.valvesoftware.Steam"

#-------------------------------Custom installs

#------------------------------- Updates and Cleaning 
update

#------------------------------- END
echo_success "Restart the computer now"

