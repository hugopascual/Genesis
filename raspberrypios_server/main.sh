#!/bin/bash

#------------------------------- Imports
# shellcheck source=/dev/null
source "./utils/installations.sh"
# shellcheck source=/dev/null
source "./utils/auxiliar.sh"
# shellcheck source=/dev/null
source "./utils/dit.sh"

#------------------------------- Start
echo_info "Starting installation"

#------------------------------- Update and Upgrade
./scripts/update_system.sh

#------------------------------- Custom installations

#------------------------------- Official repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
./scripts/server_config.sh
./scripts/git_config.sh
# This one is probably needed before this installation
# ./scripts/ssh_server.sh

#------------------------------- Updates and Cleaning 
./scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
