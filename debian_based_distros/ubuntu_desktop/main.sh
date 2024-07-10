#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
UTILS_DIR="$BASE_DIR/functions/"
SCRIPTS_DIR="$BASE_DIR/scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$UTILS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Starts
echo_info "Starting installation"

#------------------------------- Update and Upgrade
# TODO search for a better execution of scripts
"$SCRIPTS_DIR"update_system.sh

#------------------------------- Basic
install_flatpak
install_auto_firma_fnmt
install_config_fnmt
install_nvtop
install_fastfetch
install_displaylink_driver
apt_get_install "Basic utilities" "wget curl net-tools htop tree"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"
apt_get_install "Firefox" "firefox"
apt_get_install "Teminator" "terminator"

#------------------------------- Development
# install_nodejs
install_docker
install_VScode
install_jetbrains_toolbox
install_github_cli

#------------------------------- Games
install_lutris

#------------------------------- Services
# install_proton_vpn

#------------------------------- Extra Funcionalities
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
# ssh_server_activate

#------------------------------- Configuration
"$SCRIPTS_DIR"desktop_config.sh
"$SCRIPTS_DIR"git_config.sh

#------------------------------- Updates and Cleaning 
"$SCRIPTS_DIR"update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
