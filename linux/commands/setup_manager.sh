#!/bin/bash

##
# @Description
# 
##
setup_command() {
    check_option_supported "$OPTION_SELECTED" \
        "$INSTALLATION_TYPE_NOT_VALID_MESSAGE" \
        "${INSTALL_COMMAND_TYPES[@]}"

    export DISTRO_PLUS_TYPE="${DISTRO_SELECTED}_${OPTION_SELECTED}"

    echo_info "Starting setup for $DISTRO_PLUS_TYPE"
    # shellcheck disable=SC1090
    source "$SETUP_FUNCTIONS_PATH/$DISTRO_PLUS_TYPE.sh"
}
