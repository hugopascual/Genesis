#!/bin/bash

#------------------------------- Imports
# Get the path to the main BASE_DIR.
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


#------------------------------- Official repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
"$BASE_DIR"/scripts/server_config.sh
"$BASE_DIR"/scripts/git_config.sh
# This one is probably needed before this installation
# "$BASE_DIR"/scripts/ssh_server.sh

#------------------------------- Updates and Cleaning 
"$BASE_DIR"/scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
