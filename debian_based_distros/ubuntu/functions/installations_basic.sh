#!/bin/bash

##########################
#--Basic funcionalities--#
##########################

##
# @Description
# Install Fastfetch
# Terminal tool used to show the characteristics of the machine in a pretty way 
# https://github.com/fastfetch-cli/fastfetch
##
install_fastfetch() {
	echo_info "Fastfetch"
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update
    sudo apt install -y fastfetch
    echo_installed "Fastfetch"
}

##
# @Description
# Uninstall Fastfetch
#  
##
uninstall_fastfetch() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

######################
#--Hardware related--#
######################

##
# @Description
# Install Displylink driver
# Drivers to use displays with hubs
# https://www.synaptics.com/products/displaylink-graphics/downloads
##
install_displaylink_driver() {
    echo_installing "Displaylink driver"
    wget https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
    sudo apt install -y ./synaptics-repository-keyring.deb
    sudo apt update
    sudo apt install -y displaylink-driver
    sudo rm synaptics-repository-keyring.deb
    echo_installed "Displaylink driver"
}

##
# @Description
# Uninstall Displylink driver
#  
##
uninstall_displaylink_driver() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}



######################
#--Package managers--#
######################

##
# @Description
# Install Flatpak package manager
# https://flatpak.org/setup/Ubuntu
##
install_flatpak() {
    echo_installing "Flatpak (only command line)"
    sudo apt install -y flatpak
    # add the Flathub repository
    FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"
    echo_installed "Flatpak"
}

##
# @Description
# Uninstall Flatpak package manager
#  
##
uninstall_flatpak() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

###########################
#--Public Administration--#
###########################

##
# @Description
# Install Autofirma from FNMT
# https://firmaelectronica.gob.es/Home/Descargas.html
##
install_autofirma() {
	echo_installing "AutoFirma"
	curl -OL https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip
	unzip AutoFirma_Linux_Debian.zip
	sudo apt install -y ./*.deb
    rm AutoFirma*
	echo_installed "AutoFirma"
}

##
# @Description
# Uninstall Autofirma from FNMT
#  
##
uninstall_autofirma() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

##
# @Description
# Install Configurador FNMT
# App for requesting keys needed to obtain a spanish digital certificate
# https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
##
install_config_fnmt() {
    echo_installing "Configurador FNMT"
    sudo apt install -y default-jdk
    wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
    sudo apt install -y ./configuradorfnmt*
    rm configuradorfnmt*
    echo_installed "Configurador FNMT"    
}

##
# @Description
# Uninstall Configurador FNMT
#  
##
uninstall_config_fnmt() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}