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

###########################
#--Other Usage Functions--#
###########################
##
# @Description
#
##
help_message() {
    echo \
"
Usage:  ./linux.sh install { TYPE }
or      ./linux.sh update

where   TYPE := { desktop | server }
"
    exit 1
}

##
# @Description
# Open a read action on terminal in order to obtain the linux distribution used
# in the system.
# @Result
# $distro_selected Distribution selected by the user between the available ones.
##
select_distribution() {
    distro_selected="None"

    select_distro_message=$'Enter the linux distribution which desktop you wants to setup: \n'
    available_distros_message='The following distributions are avalibles on setup'
    selected_distro_message='The selected distribution is'
    not_valid_distro_message='The selected distribution is not valid'

    echo "$available_distros_message"
    for distro in "${AVAILABLE_DISTROS[@]}"; do
        echo "$distro"
    done

    read -rp "$select_distro_message" distro_selected

    if [[ ! " ${AVAILABLE_DISTROS[*]} " =~ [[:space:]]${distro_selected}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$not_valid_distro_message"
        exit 1
    fi

    echo "$selected_distro_message $distro_selected"
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
    sudo autoremove -y
    sudo autoclean -y
    echo_info "APT update finished"
}
