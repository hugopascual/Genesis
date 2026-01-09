#!/bin/bash

##
# @Description
# 
##
update_command() {
    distro_selected="$1"

    check_option_supported "$distro_selected" "${AVAILABLE_DISTROS[@]}" "$DISTRIBUTION_NOT_VALID_MESSAGE"

    # shellcheck disable=SC1090
    source "$COMMAND_UPDATE_FUNCTIONS_PATH/${distro_selected}_update.sh"
}
