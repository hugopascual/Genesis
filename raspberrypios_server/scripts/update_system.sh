#!/bin/bash

#------------------------------- Imports
# shellcheck source=/dev/null
source "../utils/auxiliar.sh"

#------------------------------- Update the system
echo_info 'Upgrading and updating packages'
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo_info "Packages upgrades and updates finished"
