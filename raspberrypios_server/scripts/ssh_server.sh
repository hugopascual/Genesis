#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$DIRECTORY/../utils/auxiliar.sh"

#------------------------------- SSH Server install
echo_info "SSH Server configuration"
sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl restart ssh
echo_success "SSH Server configuration finished"
