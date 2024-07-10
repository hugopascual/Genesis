#!/bin/bash

####################################
#--Especific Installing Functions--#
####################################
##
# @Description
# Install 
#  
##
install_template() {
	echo_installing ""
    echo_installed ""
}

##
# @Description
# Install 
#  
##
uninstall_template() {
    echo_uninstalling ""
    echo_uninstalled ""
}

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
# Install Flatpak package manager
#  
##
uninstall_flatpak() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

##
# @Description
# Install Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
##
install_VScode() {
    VSCODE_DEB_URL="https://go.microsoft.com/fwlink/?LinkID=760868"
    deb_download_and_install "Visual Studio Code" "$VSCODE_DEB_URL"
}

##
# @Description
# Install 
#  
##
uninstall_template() {
    echo_uninstalling ""
    echo_uninstalled ""
}

# TODO make a review if this continue to work
##
# @Description
# Install nodejs and npm
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
##
install_nodejs() {
    echo_installing "nodejs"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    
    # NODE_MAJOR could be changed depending on the version you need
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    
    sudo apt-get update
    sudo apt-get install nodejs -y
    echo_installed "nodejs"
}

# TODO make a review if this continue to work
##
# @Description
# Uninstall nodejs and npm
# https://github.com/nodesource/distributions#installation-instructions
##
uninstall_nodejs() {
    echo_info "Removing node from system"
    apt-get purge nodejs &&\
    rm -r /etc/apt/sources.list.d/nodesource.list &&\
    rm -r /etc/apt/keyrings/nodesource.gpg
    echo_success "Nodejs successfully removed"
}


##
# @Description
# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
##
install_docker() {
    echo_installing "Docker"
    # Remove previous installations
    uninstall_docker
    
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    echo_installed "Docker"
}   

##
# @Description
# Uninstall Docker
# https://docs.docker.com/engine/install/ubuntu/
##
uninstall_docker() {
    # Uninstall old versions and unofficial packages
    PACKAGES_LIST=(
        "docker.io" 
        "docker-doc" 
        "docker-compose" 
        "docker-compose-v2" 
        "podman-docker" 
        "containerd" 
        "runc")
    for pkg in "${PACKAGES_LIST[@]}"; 
        do sudo apt-get remove $pkg; 
    done

    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}

##
# @Description
# Install jetbrains-toolbox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
##
install_jetbrains_toolbox() {
    echo_installing "JetBrains Toolbox"
    tar_file="jetbrains-toolbox-2.4.0.32175.tar.gz"
    # Descargar el tar.gz
    curl -OL https://download.jetbrains.com/toolbox/$tar_file
    # Descomprimir el tar.gz
    sudo tar -xzf "$tar_file"
    # Mover el directorio descomprimido a /opt
    descompressed_dir="${tar_file: : -7}"
    sudo mv "$descompressed_dir" /opt/
    # Ejecutar el binario de dentro
    /opt/"$descompressed_dir"/jetbrains-toolbox
    # Borrar los restos
    sudo rm -rf /opt/"$descompressed_dir"
    sudo rm -f "$tar_file"
    echo_installed "JetBrains Toolbox"
}

##
# @Description
# Install 
#  
##
uninstall_template() {
    echo_uninstalling ""
    echo_uninstalled ""
}

##
# @Description
# Install ProtonVPN
# https://protonvpn.com/support/linux-ubuntu-vpn-setup/
# https://protonvpn.com/support/linux-vpn-tool/
##
install_proton_vpn() {
    echo_installing "ProtonVPN"
    proton_package_name="protonvpn-stable-release_1.0.3_all.deb"
    # Descargar el .deb
    curl -OL https://repo.protonvpn.com/debian/dists/stable/main/binary-all/$proton_package_name
    # Install the package
    sudo apt-get install -y ./$proton_package_name
    sudo rm $proton_package_name
    sudo apt-get update
    # Install the grafic interface
    sudo apt-get -y install protonvpn
    # Install top pin
    sudo apt install -y gnome-shell-extension-appindicator gir1.2-appindicator3-0.1
    # Install command client
    sudo apt-get -y install protonvpn-cli
    echo_installed "ProtonVPN"
}

##
# @Description
# Install Autofirma from FNMT
# https://firmaelectronica.gob.es/Home/Descargas.html
##
install_auto_firma_fnmt() {
	echo_installing "AutoFirma"
	curl -OL https://estaticos.redsara.es/comunes/autofirma/currentversion/AutoFirma_Linux_Debian.zip
	unzip AutoFirma_Linux_Debian.zip
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

##
# @Description
# Install Lutris
# This software is used to install windows games on Linux
# https://www.addictivetips.com/ubuntu-linux-tips/hearthstone-linux/
##
install_lutris() {
    echo_installing "Lutris"
    sudo add-apt-repository -y ppa:lutris-team/lutris
    sudo apt-get update
    sudo apt-get -y install lutris
	echo_installed "Lutris"
}

##
# @Description
# Install GitHub CLI
# Github client to make login via terminal
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
##
install_github_cli() {
    echo_installing "GitHub CLI"
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
    echo_installed "GitHub CLI"
}


##
# @Description
# Install NVTop
# Software to monitor the usage of GPU
# https://github.com/Syllo/nvtop
##
install_nvtop() {
	echo_installing "NVTop"
    sudo add-apt-repository -y ppa:flexiondotorg/nvtop
    sudo apt update
    sudo apt install -y nvtop
    echo_installed "NVTop"
}

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
