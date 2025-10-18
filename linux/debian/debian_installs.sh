#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

##
# @Description
# Install some basic functionalities
##
debian_install_basics() {
    # TODO include sudo install
    apt_get_install "htop"
    apt_get_install "tree"
    apt_get_install "nfs-common"
    apt_get_install "rename"
    apt_get_install "rsync"
    apt_get_install "lshw"
}

##
# @Description
# Install basic net tools (wget, curl and net-tools)
##
debian_install_basics_network() {
    apt_get_install "wget"
    apt_get_install "curl"
    apt_get_install "net-tools"
    apt_get_install "software-properties-common"
}

##
# @Description
# Install Fastfetch
# Terminal tool used to show the characteristics of the machine in a pretty way
# https://github.com/fastfetch-cli/fastfetch
##
debian_install_fastfetch() {
    URL="https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.deb"
    deb_download_and_install "$URL"
}

################################################################################
#-- Development --#
################################################################################

##
# @Description
# Install some basic development software
##
debian_install_basics_development() {
    apt_get_install "git"
    apt_get_install "default-jre"
}

##
# @Description
# Install Docker
# https://docs.docker.com/engine/install/ubuntu/
##
debian_install_docker() {
    # Remove previous installations
    ubuntu_uninstall_docker

    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
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
debian_uninstall_docker() {
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

##
# @Description
# Install lazydocker
# https://github.com/jesseduffield/lazydocker
##
debian_install_lazydocker() {
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    sudo mv .local/bin/lazydocker /usr/local/bin/
    rm -d .local/bin/
    rm -d .local/
}

##
# @Description
# Install Python
##
debian_install_python() {
    apt_get_install "python3"
    apt_get_install "python3-venv"
    apt_get_install "python3-pip"
}

################################################################################
#-- DIT Software --#
################################################################################

################################################################################
#-- Desktop --#
################################################################################

################################################################################
#-- Hobbys --#
################################################################################
