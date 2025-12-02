#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

raspberrypi_install_basics() {
    apt_get_install "htop"
    apt_get_install "tree"
    apt_get_install "nfs-common"
    apt_get_install "rename"
    apt_get_install "rsync"
    apt_get_install "lshw"
}

raspberrypi_install_basics_network() {
    apt_get_install "wget"
    apt_get_install "curl"
    apt_get_install "net-tools"
    apt_get_install "software-properties-common"
}

raspberrypi_install_fastfetch() {
    URL="https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.deb"
    deb_download_and_install "$URL"
}

################################################################################
#-- Development --#
################################################################################

raspberrypi_install_basics_development() {
    apt_get_install "git"
    apt_get_install "default-jre"
}

raspberrypi_install_docker() {
    # Remove old packages
    sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)

    # Add Docker's official GPG key:
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    sudo apt update

    # Install the packages
    sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

##
# @Description
# Install lazydocker
# https://github.com/jesseduffield/lazydocker
##
raspberrypi_install_lazydocker() {
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    sudo mv "$HOME/.local/bin/lazydocker" /usr/local/bin/
}

raspberrypi_install_python() {
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
