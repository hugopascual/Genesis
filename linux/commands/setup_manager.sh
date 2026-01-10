#!/bin/bash

##
# @Description
# 
##
setup_command() {
    check_option_supported "$OPTION_SELECTED" \
        "${INSTALL_COMMAND_TYPES[@]}" \
        "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"

    export DISTRO_PLUS_TYPE="${DISTRO_SELECTED}_${OPTION_SELECTED}"

    # shellcheck disable=SC1090
    source "$SETUP_FUNCTIONS_PATH/$DISTRO_PLUS_TYPE.sh"
}
