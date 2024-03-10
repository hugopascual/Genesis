#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
SCRIPTS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$SCRIPTS_DIR/../utils/auxiliar.sh"

#------------------------------- Update the system
echo_info 'Upgrading and updating packages'
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo_info "Packages upgrades and updates finished"

echo_info "Flatpak updates started"
flatpak update
echo_info "Flatpak updates finished"

echo_info "Snap updates started"
sudo snap refresh
echo_info "Snap updates finished"
