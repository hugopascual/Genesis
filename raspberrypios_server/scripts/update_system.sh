#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

AUXILIAR_FILEPATH="$DIRECTORY/support_scripts/functions.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

#------------------------------- Update the system
echo_info 'Upgrading and updating packages'
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo_info "Packages upgrades and updates finished"
