#!/bin/bash

####################
#--Echo functions--#
####################
# Colors and more
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
BHIGreen='\033[1;92m' # Bold High Intensity Green
BHIYellow='\033[1;93m' # Bold High Intensity Green
BHICyan='\033[1;96m' # Bold High Intensity Cyan
NoColor='\033[0m'

echo_info() {
    echo -e "${BHICyan}$1${NoColor}"
}

echo_success() {
    echo -e "${BHIGreen}$1${NoColor}"
}

echo_other() {
    echo -e "${BHIYellow}$1${NoColor}"
}

echo_installing() {
    echo -e "${BHICyan}Installing $1${NoColor}"
}

echo_installed() {
    echo -e "${BHIGreen}$1 installed${NoColor}"
}

echo_uninstalling() {
    echo -e "${BHICyan}Uninstalling $1${NoColor}"
}

echo_uninstalled() {
    echo -e "${BHIGreen}$1 uninstalled${NoColor}"
}

###########################
#--Other Usage Functions--#
###########################
##
# @Description
# $1 Option to check
# $2 Supported options list
# $3 Error message to show if option not supported
##
check_option_supported() {
    option="$1"
    supported_options=("${@:2}")
    error_message="$3"

    if [[ ! " ${supported_options[*]} " =~ [[:space:]]${option}[[:space:]] ]]; then
        echo "$error_message"
        help
    fi
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
apt_get_install() {
    apt-get install -y "$1"
}

##
# @Description
# Install a software package using pacman
# @Params
# $1 Name of the pacman package software wanted to be installed
##
pacman_install() {
    pacman -Syu --noconfirm "$1"
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
    flatpak install -y flathub "$1"
}

##
# @Description
# Install a software package via snap
# @Params
# $1 Name of the apt package software wanted to be installed
##
snap_install() {
    snap install "$1"
}

##
# @Description
# Install a software package downloading the deb package
# @Params
# $1 URL of deb package to install
##
deb_download_and_install() {
    wget --content-disposition "$1"
    apt-get install -y ./*.deb
    rm ./*.deb
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
    flatpak update -y
    echo_info "Flatpak update finished"
}

##
# @Description
# Snap packages update
##
update_snap() {
    echo_info "Snap update started"
    snap refresh
    echo_info "Snap update finished"
}

##
# @Description
# APT packages update and cleanup
##
update_apt() {
    echo_info "APT update started"
    apt update -y
    apt upgrade -y
    apt autoremove -y
    apt autoclean -y
    echo_info "APT update finished"
}

##
# @Description
# Pacman packages update and cleanup
##
update_pacman() {
    echo_info "Pacman update started"
    pacman -Syu --noconfirm
    echo_info "Pacman update finished"
}
