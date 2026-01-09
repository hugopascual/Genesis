#!/bin/bash

##
# @Description
# 
##
setup_command() {
    setup_type="$2"
    check_option_supported "$setup_type" \
        "${INSTALL_COMMAND_TYPES[@]}" \
        "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"

    export DISTRO_PLUS_TYPE="${DISTRO_SELECTED}_${setup_type}"

    # shellcheck disable=SC1090
    source "$COMMAND_SETUP_FUNCTIONS_PATH/$DISTRO_PLUS_TYPE.sh"
}
