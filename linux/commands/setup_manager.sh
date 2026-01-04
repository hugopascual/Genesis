#!/bin/bash

##
# @Description
# 
##
setup_command() {
    setup_type="$1"
    distro_selected="$2"

    check_option_supported "$setup_type" "${SETUP_TYPES[@]}" "$SETUP_TYPE_NOT_VALID_MESSAGE"
    check_option_supported "$distro_selected" "${AVAILABLE_DISTROS[@]}" "$DISTRIBUTION_NOT_VALID_MESSAGE"

    # shellcheck disable=SC1090
    source "$COMMAND_SETUP_PATH/${distro_selected}_${setup_type}.sh"
}
