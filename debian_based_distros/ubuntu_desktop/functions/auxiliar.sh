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
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
##
apt_get_install() {
    echo_installing "$1 via apt-get"
    sudo apt-get install -y "$2"
    echo_installed "$1"
}

##
# @Description
# Install a software package from flathub via flatpak
# @Params
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
##
flathub_install() {
    echo_installing "$1 via flatpak"
    flatpak install -y flathub "$2"
    echo_installed "$1"
}

##
# @Description
# Install a software package via snap
# @Params
# $1 Name of the software, just to print
# $2 Name of the apt package software wanted to be installed
# $3 Option used in snap intallations
##
snap_install() {
    echo_installing "$1 via snap"
    sudo snap install "$2" "$3"
    echo_installed "$1"
}

##
# @Description
# Install a software package downloading the deb package
# @Params
# $1 Name of the software, just to print
# $2 URL of deb package to install
##
deb_download_and_install() {
    echo_installing "$1 via deb package"
    wget --content-disposition "$2"
    sudo apt-get install -y ./*.deb
    rm ./*.deb
    echo_installed "$1"
}
