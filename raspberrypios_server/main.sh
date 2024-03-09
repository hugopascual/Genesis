#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

DESKTOP_CONFIG_FILEPATH="$DIRECTORY/scripts/desktop_config.sh"
# shellcheck source=/dev/null
source "$DESKTOP_CONFIG_FILEPATH"

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

#------------------------------- Configurations
./"$DIRECTORY"/scripts/server_config.sh

#------------------------------- Update and Upgrade
update

#------------------------------- Custom installations

#------------------------------- Ubuntu repository installs

#------------------------------- Snap installs

#------------------------------- Flatpak installs

#------------------------------- DIT Installs and config
install_openvpnc

#------------------------------- Additional Config
git_config

#------------------------------- Updates and Cleaning 
update

#------------------------------- END
echo_success "Restart the computer now"
