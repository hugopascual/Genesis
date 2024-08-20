#!/bin/bash

##
# @Description
# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
##
ubuntu_install_docker() {
    # Remove previous installations
    ubuntu_uninstall_docker
    
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install -y curl
    sudo apt-get install -y ca-certificates
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update

    sudo apt-get install -y docker-ce  
    sudo apt-get install -y docker-ce-cli
    sudo apt-get install -y containerd.io 
    sudo apt-get install -y docker-buildx-plugin
    sudo apt-get install -y docker-compose-plugin
}

##
# @Description
# Uninstall Docker
# https://docs.docker.com/engine/install/ubuntu/
##
ubuntu_uninstall_docker() {
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
        do sudo apt-get remove -y $pkg; 
    done

    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
}