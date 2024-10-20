#!/bin/bash

##########################
#--Basic funcionalities--#
##########################

##
# @Description
# Install basic net tools (wget, curl and net-tools)
##
install_net_basic() {
    apt_get_install "wget"
    apt_get_install "curl"
    apt_get_install "net-tools"
    apt_get_install "software-properties-common"
}

##
# @Description
# Install funcionalities (htop, tree, git and Java Runtime Env)
##
install_common_funcionalities() {
    apt_get_install "htop"
    apt_get_install "tree"
    apt_get_install "git"
    apt_get_install "default-jre"
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
    URL="https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb"
    wget "$URL"
    sudo apt install -y ./synaptics-repository-keyring.deb
    sudo apt update
    sudo apt install -y displaylink-driver
    sudo rm synaptics-repository-keyring.deb
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
    sudo apt install -y flatpak
    # add the Flathub repository
    FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"
}

###############
#--Utilities--#
###############

##
# @Description
# Install Terminator
##
install_terminator() {
    apt_get_install "terminator"
}

##
# @Description
# Install Fastfetch
# Terminal tool used to show the characteristics of the machine in a pretty way 
# https://github.com/fastfetch-cli/fastfetch
##
install_fastfetch() {
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update
    sudo apt install -y fastfetch
}

##
# @Description
# Install NVTop
##
install_nvtop() {
    apt_get_install "nvtop"
}

##
# @Description
# Install Firefox
##
install_firefox() {
    apt_get_install "firefox"
}

##
# @Description
# Install Thunderbird
##
install_thunderbird() {
    flathub_install "org.mozilla.Thunderbird"
}

##
# @Description
# Install KeePassXC
##
install_keepassxc() {
    flathub_install "org.keepassxc.KeePassXC"
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
    URL="https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip"
	curl -OL "$URL"
	unzip "AutoFirma_Linux_Debian.zip"
	sudo apt install -y ./*.deb
    rm AutoFirma*
	echo_installed "AutoFirma"
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
