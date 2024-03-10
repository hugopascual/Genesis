#!/bin/bash

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"

# shellcheck source=/dev/null
source "$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$DIRECTORY/utils/installations.sh"
# shellcheck source=/dev/null
source "$DIRECTORY/utils/dit.sh"

#------------------------------- Start
echo_info "Starting installation"

#------------------------------- Update and Upgrade
"$DIRECTORY"/scripts/update_system.sh

#------------------------------- Custom installations


#------------------------------- Official repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
"$DIRECTORY"/scripts/server_config.sh
"$DIRECTORY"/scripts/git_config.sh
# This one is probably needed before this installation
# "$DIRECTORY"/scripts/ssh_server.sh

#------------------------------- Updates and Cleaning 
"$DIRECTORY"/scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
