#!/bin/bash

##########################
#--Basic funcionalities--#
##########################

##
# @Description
# Install basic net tools (wget, curl and net-tools)
##
linux_install_net_basic() {
    NAME="Net basics"
	echo_installing "$NAME"
    install_net_basic
    echo_installed "$NAME"
}

##
# @Description
# Install funcionalities (htop, tree, git and Java Runtime Env)
##
linux_install_common_funcionalities() {
    NAME="Common funcionalities"
	echo_installing "$NAME"
    install_common_funcionalities
    mkdir "$HOME/dev"
    mkdir "$HOME/dev/$USER"
    mkdir "$HOME/dev/STRAST"
    echo_installed "$NAME"
}

######################
#--Hardware related--#
######################

##
# @Description
# Install Displylink driver
# Drivers to use displays with hubs
##
linux_install_displaylink_driver() {
    NAME="Displaylink driver"
	echo_installing "$NAME"
    install_displaylink_driver
    echo_installed "$NAME"
}

######################
#--Package managers--#
######################

##
# @Description
# Install Flatpak package manager
##
linux_install_flatpak() {
    NAME="Flatpak (only command line)"
	echo_installing "$NAME"
    install_flatpak
    echo_installed "$NAME"
}

###############
#--Utilities--#
###############

##
# @Description
# Install Terminator
##
linux_install_terminator() {
    NAME="Terminator"
	echo_installing "$NAME"
    install_terminator
    echo_installed "$NAME"
}

##
# @Description
# Install Fastfetch
# Terminal tool used to show the characteristics of the machine in a pretty way 
##
linux_install_fastfetch() {
    NAME="Fastfetch"
	echo_installing "$NAME"
    install_fastfetch
    echo_installed "$NAME"
}

##
# @Description
# Install NVtop
##
linux_install_nvtop() {
    NAME="NVtop"
	echo_installing "$NAME"
    install_nvtop
    echo_installed "$NAME"
}

##
# @Description
# Install Firefox
##
linux_install_firefox() {
    NAME="Firefox"
	echo_installing "$NAME"
    install_firefox
    echo_installed "$NAME"
}

##
# @Description
# Install Thunderbird
##
linux_install_thunderbird() {
    NAME="Thunderbird"
	echo_installing "$NAME"
    install_thunderbird
    echo_installed "$NAME"
}

##
# @Description
# Install KeePassXC
##
linux_install_keepassxc() {
    NAME="KeePassXC"
	echo_installing "$NAME"
    install_keepassxc
    echo_installed "$NAME"
}

###########################
#--Public Administration--#
###########################

##
# @Description
# Install Autofirma from FNMT
##
linux_install_autofirma() {
    NAME="Autofirma"
	echo_installing "$NAME"
    install_autofirma
    echo_installed "$NAME"
}

##
# @Description
# Install Configurador FNMT
# App for requesting keys needed to obtain a spanish digital certificate
##
linux_install_config_fnmt() {
    NAME="Config FNMT"
	echo_installing "$NAME"
    install_config_fnmt
    echo_installed "$NAME"
}
