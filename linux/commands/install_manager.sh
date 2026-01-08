#!/bin/bash

##
# @Description
# 
##
install_command() {
    installation_type="$2"
    check_option_supported "$installation_type" "${INSTALL_COMMAND_TYPES[@]}" "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"

    # shellcheck disable=SC1090
    source "$INSTALLATIONS_FUNCTIONS_PATH/$DISTRO_SELECTED.sh"

    case $installation_type in
        "$INSTALL_TYPE_PERSONAL")
            personal_installation
            ;;
        "$INSTALL_TYPE_SERVER")
            server_installation
            ;;
        *)
            echo "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
            ;;
    esac
}

personal_installation() {
    echo 'personal installation'
}

server_installation() {
    echo 'server installation'
}