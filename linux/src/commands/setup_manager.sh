#!/bin/bash

##
# @Description
# 
##
setup_command() {
    check_option_supported "$OPTION_SELECTED" \
        "$SETUP_NOT_VALID_MESSAGE" \
        "${SETUP_TYPES[@]}"

    log_info "Starting setup for $DISTRO_PLUS_TYPE"
    # shellcheck disable=SC1090
    source "$SETUP_SCRIPTS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED.sh"
}
