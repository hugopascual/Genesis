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
#
##
check_distribution() {
    distro_selected="$1"

    if [[ ! " ${AVAILABLE_DISTROS[*]} " =~ [[:space:]]${distro_selected}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$DISTRIBUTION_NOT_VALID_MESSAGE"
        help_message
    fi
}

##
# @Description
#
##
check_desktop_environment() {
    desktop_environment_type="$1"

    if [[ ! " ${CUSTOMIZATION_TYPES[*]} " =~ [[:space:]]${desktop_environment_type}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$DESKTOP_ENVIRONMENT_TYPE_NOT_VALID_MESSAGE"
        help_message
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
    sudo apt-get install -y "$1"
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
