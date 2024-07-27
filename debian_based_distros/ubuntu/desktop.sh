#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
BASE_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
FUNCTIONS_DIR="$BASE_DIR/functions/"
SCRIPTS_DIR="$BASE_DIR/scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$FUNCTIONS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Starts
echo_info "Starting installation"

#------------------------------- Update and Upgrade
# TODO search for a better execution of scripts
"$SCRIPTS_DIR"update_system.sh

#------------------------------- Basic
apt_get_install "Mix of basic Sfotware" "wget curl net-tools htop tree"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"
apt_get_install "Firefox" "firefox"
apt_get_install "Teminator" "terminator"
flathub_install "Thunderbird" "org.mozilla.Thunderbird"
flathub_install "KeePassXC" "org.keepassxc.KeePassXC"
install_fastfetch
install_displaylink_driver
install_flatpak
install_autofirma
install_config_fnmt

#------------------------------- Development
install_docker
install_VScode
install_jetbrains_toolbox   
install_github_cli

#------------------------------- Games
install_steam
install_minecraft

#------------------------------- Services
install_spotify
flathub_install "Telegram" "org.telegram.desktop"

#------------------------------- Extra
apt_get_install "GNU Image Manipulation Program" "gimp"
apt_get_install "Raspberry Pi OS Imager" "rpi-imager"
snap_install "VLC" "vlc"
flathub_install "Google Chrome" "com.google.Chrome"
install_obsidian

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
"$SCRIPTS_DIR"desktop_config.sh
"$SCRIPTS_DIR"git_config.sh

#------------------------------- Updates and Cleaning 
"$SCRIPTS_DIR"update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
