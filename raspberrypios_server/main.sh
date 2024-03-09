#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

INSTALLATIONS_FILEPATH="$DIRECTORY/utils/installations.sh"
# shellcheck source=/dev/null
source "$INSTALLATIONS_FILEPATH"

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

DIT_FILEPATH="$DIRECTORY/utils/dit.sh"
# shellcheck source=/dev/null
source "$DIT_FILEPATH"

echo_info "Starting installation"

#------------------------------- Update and Upgrade
./"$DIRECTORY"/scripts/update_system.sh

#------------------------------- Custom installations
install_nodejs
install_docker

#------------------------------- Official repository installs
apt_get_install "Basic utilities" "wget curl"
apt_get_install "Git" "git"
apt_get_install "Java" "default-jre"

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Configuration
./"$DIRECTORY"/scripts/git_config.sh
# This one is probably needed before this installation
# ./"$DIRECTORY"/scripts/ssh_server.sh

#------------------------------- Updates and Cleaning 
./"$DIRECTORY"/scripts/update_system.sh

#------------------------------- END
echo_success "Restart the computer now"
