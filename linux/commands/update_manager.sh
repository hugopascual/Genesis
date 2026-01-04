#!/bin/bash

### Update command
update_manager() {
    distro_selected="$1"
    check_distribution "$distro_selected"

    update_script_path="$BASE_PATH/distributions/$distro_selected/${distro_selected}_update.sh"
    # shellcheck disable=SC1090
    source "$update_script_path"
    system_update
}

######################
#--Update Functions--#
######################
##
# @Description
# Flatpak packages update
##
update_flatpak() {
    echo_info "Flatpak update started"
    sudo flatpak update -y
    echo_info "Flatpak update finished"
}

##
# @Description
# Snap packages update
##
update_snap() {
    echo_info "Snap update started"
    sudo snap refresh
    echo_info "Snap update finished"
}

##
# @Description
# APT packages update
##
update_apt() {
    echo_info "APT update started"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
    echo_info "APT update finished"
}
