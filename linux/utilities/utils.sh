#!/bin/bash

######################
#--Logging Functions--#
######################
##
# @Description
# Initialize the log file and create logs directory if it doesn't exist
##
init_log() {
    if [[ "${GENESIS_LOG_ENABLED}" != "true" ]]; then
        return 0
    fi
    
    # Create logs directory if it doesn't exist
    mkdir -p "$LOGS_PATH"
    
    # Initialize log file with header
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "========================================
Genesis Linux - Log Session Started
Timestamp: $timestamp
========================================
" >> "$LOG_FILE"
}

##
# @Description
# Write a message to the log file with standard format
# @Params
# $1 Log level (INFO, SUCCESS, WARNING, ERROR, etc.)
# $2 Message to log
##
log() {
    if [[ "${GENESIS_LOG_ENABLED}" != "true" ]]; then
        return 0
    fi
    
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_text="[$level: $timestamp] $message"

    echo "$log_text"
    echo "$log_text" >> "$LOG_FILE"
}

log_severe() {
    log "$LOG_LEVEL_SEVERE" "$1"
}

log_warning() {
    log "$LOG_LEVEL_WARNING" "$1"
}

log_info() {
    log "$LOG_LEVEL_INFO" "$1"
}

log_config() {
    log "$LOG_LEVEL_CONFIG" "$1"
}

log_fine() {
    log "$LOG_LEVEL_FINE" "$1"
}

log_finer() {
    log "$LOG_LEVEL_FINER" "$1"
}

log_finest() {
    log "$LOG_LEVEL_FINEST" "$1"
}

###########################
#--Other Usage Functions--#
###########################
##
# @Description
# $1 Option to check
# $2 Error message to show if option not supported
# $3 Supported options list
##
check_option_supported() {
    option="$1"
    error_message="$2"
    local supported_options=("${@:3}")

    if [[ ! " ${supported_options[*]} " =~ [[:space:]]${option}[[:space:]] ]]; then
        echo "$error_message"
        help
    fi
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

##################################
#--Generic Installing Functions--#
##################################
##
# @Description
# Install a software package using apt-get
# @Params
# $1 Name of the apt package software wanted to be installed
##
apt_install() {
    sudo apt install -y "$1"
}

##
# @Description
# Install a software package using pacman
# @Params
# $1 Name of the pacman package software wanted to be installed
##
pacman_install() {
    sudo pacman -Syu --noconfirm "$1"
}

##
# @Description
# Install a software package using yay
# @Params
# $1 Name of the yay package software wanted to be installed
##
yay_install() {
    yay -Syu --noconfirm "$1"
}

##
# @Description
# Install a software package from flathub via flatpak
# @Params
# $1 Name of the apt package software wanted to be installed
##
flathub_install() {
    sudo flatpak install -y flathub "$1"
}

##
# @Description
# Install a software package via snap
# @Params
# $1 Name of the apt package software wanted to be installed
##
snap_install() {
    sudo snap install "$1"
}

##
# @Description
# Install a software package downloading the deb package
# @Params
# $1 URL of deb package to install
##
deb_download_and_install() {
    wget --content-disposition "$1"
    sudo apt-get install -y ./*.deb
    rm ./*.deb
}
