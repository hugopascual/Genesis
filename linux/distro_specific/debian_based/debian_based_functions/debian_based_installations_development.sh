#!/bin/bash

########################
#--Execution software--#
########################

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
# Install Docker
##
install_docker() {
    case "$CHILD_DISTRO" in
        "ubuntu")
            ubuntu_install_docker
            ;;
        "debian")
            debian_install_docker
            ;;
        *)
            debian_install_docker
            ;;
    esac
}

##
# @Description
# Uninstall Docker
##
uninstall_docker() {
    case "$CHILD_DISTRO" in
        "ubuntu")
            ubuntu_uninstall_docker
            ;;
        "debian")
            debian_uninstall_docker
            ;;
        *)
            debian_uninstall_docker
            ;;
    esac
}

##
# @Description
# Install NodeJS and npm
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
##
install_nodejs() {
    # TODO make a review if this continue to work
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    
    # NODE_MAJOR could be changed depending on the version you need
    NODE_MAJOR=20
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    
    sudo apt-get update
    sudo apt-get install nodejs -y
}

##
# @Description
# Uninstall NodeJS and npm
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04
##
uninstall_nodejs() {
    # TODO make a review if this continue to work
    apt-get purge nodejs &&\
    rm -r /etc/apt/sources.list.d/nodesource.list &&\
    rm -r /etc/apt/keyrings/nodesource.gpg
}

##############################
#--Code editors/enviroments--#
##############################

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
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}
