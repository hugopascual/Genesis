#!/bin/bash

##
# @Description
# 
##
update_command() {

    # shellcheck disable=SC1090
    source "$UPDATE_FUNCTIONS_PATH/${DISTRO_SELECTED}_update.sh"
}
