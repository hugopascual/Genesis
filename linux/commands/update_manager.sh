#!/bin/bash

##
# @Description
# 
##
update_command() {
    echo_info "Starting update for $DISTRO_SELECTED"
    # shellcheck disable=SC1090
    echo
    # source "$UPDATE_FUNCTIONS_PATH/${DISTRO_SELECTED}_update.sh"
}
