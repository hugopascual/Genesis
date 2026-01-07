#!/bin/bash

##
# @Description
# 
##
install_command() {
    installation_type="$1"
    distro_selected="$2"

    export DISTRO_PLUS_TYPE="${distro_selected}_${installation_type}"

    check_option_supported "$installation_type" "${INSTALL_COMMAND_TYPES[@]}" "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
    check_option_supported "$distro_selected" "${AVAILABLE_DISTROS[@]}" "$DISTRIBUTION_NOT_VALID_MESSAGE"
    
    # shellcheck disable=SC1090
    source "$COMMAND_INSTALL_PATH/$DISTRO_PLUS_TYPE.sh"
}
