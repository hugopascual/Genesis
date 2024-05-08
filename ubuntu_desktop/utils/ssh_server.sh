#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
UTILS_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$UTILS_DIR/auxiliar.sh"

########################################
#--Open the ssh server to be accessed--#
########################################
ssh_server_activate() {
    echo_info "Activating SSH Server"
    sudo apt install -y ssh
    sudo systemctl enable ssh && sudo systemctl start ssh
    echo_info "SSH Server activated"
}
