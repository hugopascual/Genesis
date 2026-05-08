#!/bin/bash

##
# @Description
# 
##
update_command() {
    log_info "Starting update for $DISTRO_SELECTED"
    # shellcheck disable=SC1090
    source "$UPDATE_FUNCTIONS_PATH/${DISTRO_SELECTED}_update.sh"
}
