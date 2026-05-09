#!/bin/bash

##
# @Description
# 
##
update_command() {
    log_info "Starting update for $DISTRO_SELECTED"
    # shellcheck disable=SC1090
    source "$UPDATE_SCRIPTS_PATH/${DISTRO_SELECTED}_update.sh"
}

######################
#--Update Functions--#
######################
##
# @Description
# Flatpak packages update
##
update_flatpak() {
    log_info "Flatpak update started"
    sudo flatpak update -y
    log_info "Flatpak update finished"
}

##
# @Description
# Snap packages update
##
update_snap() {
    log_info "Snap update started"
    sudo snap refresh
    log_info "Snap update finished"
}

##
# @Description
# APT packages update and cleanup
##
update_apt() {
    log_info "APT update started"
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean -y
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y
    log_info "APT update finished"
}

##
# @Description
# Pacman packages update and cleanup
##
update_pacman() {
    log_info "Pacman update started"
    sudo pacman -Syu --noconfirm
    log_info "Pacman update finished"
}

##
# @Description
# AUR packages update and cleanup
##
update_yay() {
    log_info "AUR packages update started"
    sudo yay -Syu --noconfirm
    log_info "AUR packages update finished"
}
