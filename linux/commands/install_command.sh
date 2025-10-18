#!/bin/bash

# Install command
install_command() {
    installation_type="$1"
    distribution_selected="$2"
    check_distribution "$distribution_selected"
    
    ### Import distro functions
    import_from_dir "$BASE_PATH/distributions/$distribution_selected"

    case $installation_type in
        "desktop")
            desktop_setup
            ;;
        "server")
            server_setup
            ;;
        *)
            echo "$INSTALLATION_TYPE_NOT_VALID_MESSAGE"
            help_message
            ;;
    esac
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
