#!/bin/bash

#########
# Basic #
#########

##
# @Description
# Install basic net tools (wget, curl and net-tools)
##
ubuntu_install_net_basic() {
    apt_get_install "wget"
    apt_get_install "curl"
    apt_get_install "net-tools"
    apt_get_install "software-properties-common"
}

##
# @Description
# Install funcionalities (htop, tree, git and Java Runtime Env)
##
ubuntu_install_common_funcionalities() {
    apt_get_install "htop"
    apt_get_install "tree"
    apt_get_install "git"
    apt_get_install "default-jre"
    apt_get_install "nfs-common"
}

##
# @Description
# Install Displylink driver
# Drivers to use displays with hubs
# https://www.synaptics.com/products/displaylink-graphics/downloads
##
ubuntu_install_displaylink_driver() {
    URL="https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb"
    wget "$URL"
    sudo apt install -y ./synaptics-repository-keyring.deb
    sudo apt update
    sudo apt install -y displaylink-driver
    sudo rm synaptics-repository-keyring.deb
}

##
# @Description
# Install Flatpak package manager
# https://flatpak.org/setup/Ubuntu
##
ubuntu_install_flatpak() {
    sudo apt install -y flatpak
    # add the Flathub repository
    FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"
}

##
# @Description
# Install Terminator
##
ubuntu_install_terminator() {
    apt_get_install "terminator"
}

##
# @Description
# Install Fastfetch
# Terminal tool used to show the characteristics of the machine in a pretty way
# https://github.com/fastfetch-cli/fastfetch
##
ubuntu_install_fastfetch() {
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update
    sudo apt install -y fastfetch
}

##
# @Description
# Install NVTop
##
ubuntu_install_nvtop() {
    apt_get_install "nvtop"
}

##
# @Description
# Install Firefox
##
ubuntu_install_firefox() {
    apt_get_install "firefox"
}

##
# @Description
# Install Thunderbird
##
ubuntu_install_thunderbird() {
    flathub_install "org.mozilla.Thunderbird"
}

##
# @Description
# Install KeePassXC
##
ubuntu_install_keepassxc() {
    flathub_install "org.keepassxc.KeePassXC"
}

##
# @Description
# Install Autofirma from FNMT
# https://firmaelectronica.gob.es/Home/Descargas.html
##
ubuntu_install_autofirma() {
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
ubuntu_install_config_fnmt() {
    echo_installing "Configurador FNMT"
    sudo apt install -y default-jdk
    wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
    sudo apt install -y ./configuradorfnmt*
    rm configuradorfnmt*
    echo_installed "Configurador FNMT"
}

###############
# Development #
###############

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

##
# @Description
# Install Python
##
install_python() {
    apt_get_install "python3"
    apt_get_install "python3-venv"
    apt_get_install "python3-pip"
}


##
# @Description
# Install NodeJS and npm
# https://nodejs.org/es/download
##
install_nodejs() {
    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"

    # Download and install Node.js:
    nvm install 22

    # Verify the Node.js version:
    node -v # Should print "v22.14.0".
    nvm current # Should print "v22.14.0".

    # Verify npm version:
    npm -v # Should print "10.9.2".
}

##
# @Description
# Install VSCode
# https://code.visualstudio.com/docs/setup/linux
##
install_vscode() {
    VSCODE_DEB_URL="https://go.microsoft.com/fwlink/?LinkID=760868"
    deb_download_and_install "$VSCODE_DEB_URL"
}

##
# @Description
# Install JetBrains ToolBox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
##
install_jetbrains_toolbox() {
    tar_file="jetbrains-toolbox-2.4.0.32175.tar.gz"
    # Descargar el tar.gz
    wget -c https://download.jetbrains.com/toolbox/$tar_file
    # Descomprimir el tar.gz
    sudo tar -xzf "$tar_file" -C /opt
    descompressed_dir="${tar_file: : -7}"
    # In some cases this could be necessary
    sudo apt-get install -y libfuse2
    # Ejecutar el binario de dentro
    /opt/"$descompressed_dir"/jetbrains-toolbox
    # Borrar los restos
    sudo rm -rf /opt/"$descompressed_dir"
    sudo rm -f "$tar_file"
}

##
# @Description
# Install GitHub CLI
# Github client to make login via terminal
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
##
install_github_cli() {
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}