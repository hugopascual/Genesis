#!/bin/bash

########################
#--Execution software--#
########################

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
# Install nodejs and npm
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
##
install_nodejs() {
    # TODO make a review if this continue to work
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

##############################
#--Code editors/enviroments--#
##############################

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
# Uninstall Visual Studio Code
#  
##
uninstall_VSCode() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
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
# Uninstall Jetbrains Toolbox
#  
##
uninstall_jetbrains_toolbox() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}

###############################
#--Other development related--#
###############################

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
# Uninstall Github CLI
#  
##
uninstall_github_cli() {
    echo_uninstalling "WIP"
    echo_uninstalled "WIP"
}