#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

##
# @Description
# Install some basic functionalities
##
ubuntu_install_basics() {
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
ubuntu_install_basics_network() {
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
ubuntu_install_fastfetch() {
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
ubuntu_install_basics_development() {
    apt_get_install "git"
    apt_get_install "default-jre"
}

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
# Install lazydocker
# https://github.com/jesseduffield/lazydocker
##
ubuntu_install_lazydocker() {
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    sudo mv "$HOME/.local/bin/lazydocker" /usr/local/bin/
    rm -d "$HOME/.local/bin/"
    rm -d "$HOME/.local/"
}

##
# @Description
# Install Python
##
ubuntu_install_python() {
    apt_get_install "python3"
    apt_get_install "python3-venv"
    apt_get_install "python3-pip"
}

##
# @Description
# Install VSCode
# https://code.visualstudio.com/docs/setup/linux
##
ubuntu_install_vscode() {
    VSCODE_DEB_URL="https://go.microsoft.com/fwlink/?LinkID=760868"
    deb_download_and_install "$VSCODE_DEB_URL"
}

##
# @Description
# Install JetBrains ToolBox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
##
ubuntu_install_jetbrains_toolbox() {
    # TODO install for all users
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
ubuntu_install_github_cli() {
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}

##
# @Description
# Install Postman
##
ubuntu_install_postman() {
    snap_install "postman"
}

##
# @Description
# Install Raspberry Pi OS Imager
##
ubuntu_install_rpi_imager() {
    apt_get_install "rpi-imager"
}

##
# @Description
# Install NodeJS and npm
# https://nodejs.org/es/download
##
ubuntu_install_nodejs() {
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

################################################################################
#-- DIT Software --#
################################################################################

##
# @Description
# Install OpenVPN
# VPN to connect to the DIT net
# TODO include the website with the tutorial from DIT
# Installation guide from OpenVPN
# https://community.openvpn.net/Pages/OpenVPN3Linux
##
ubuntu_install_openvpn() {
    # Install other necessary software
    sudo apt update
    sudo apt install -y apt-transport-https curl

    # Repository keys
    mkdir -p /etc/apt/keyrings
    curl -sSfL https://packages.openvpn.net/packages-repo.gpg > /tmp/openvpn.asc
    sudo mv /tmp/openvpn.asc /etc/apt/keyrings/openvpn.asc

    ## TODO update to change DISTRIBUTION dynamically
    DISTRIBUTION="noble"
    cp /etc/apt/sources.list.d/openvpn3.list /tmp/openvpn3.list
    echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian ${DISTRIBUTION} main" >> /tmp/openvpn3.list
    sudo mv /tmp/openvpn3.list /etc/apt/sources.list.d/openvpn3.list

    # Install OpenVPN
    sudo apt update
    sudo apt install -y openvpn3
}

##
# @Description
# Install OpenVPNC
# Legacy VPN to connect to the DIT net
# https://web.dit.upm.es/.cdc/index.php/Configuracion_manual_vpnc_en_ubuntu
##
ubuntu_install_openvpnc() {
    sudo apt-get update
    sudo apt-get -y install vpnc
}

################################################################################
#-- Desktop --#
################################################################################

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
# Install NVTop
##
ubuntu_install_nvtop() {
    apt_get_install "nvtop"
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
# Install Firefox
##
ubuntu_install_firefox() {
    apt_get_install "firefox"
}

##
# @Description
# Install Google Chrome
##
ubuntu_install_google_chrome() {
    flathub_install "com.google.Chrome"
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
    URL="https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Debian.zip"
	curl -OL "$URL"
	unzip "Autofirma_Linux_Debian.zip"
	sudo apt install -y ./*.deb
    rm Autofirma*
	echo_installed "AutoFirma"
}

##
# @Description
# Install Configurador FNMT
# App for requesting keys needed to obtain a spanish digital certificate
# https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
##
ubuntu_install_config_fnmt() {
    # TODO add to installations
    echo_installing "Configurador FNMT"
    sudo apt install -y default-jdk
    wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
    sudo apt install -y ./configuradorfnmt*
    rm configuradorfnmt*
    echo_installed "Configurador FNMT"
}

##
# @Description
# Install Obsidian
# https://obsidian.md/download
##
ubuntu_install_obsidian() {
    URL_DEB="https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb"
    deb_download_and_install "$URL_DEB"
}

##
# @Description
# Install VLC
##
ubuntu_install_vlc() {
    apt_get_install "vlc"
}

##
# @Description
# Install Spotify
# https://www.spotify.com/us/download/linux/
##
ubuntu_install_spotify() {
    curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update
    sudo apt-get install spotify-client
}

##
# @Description
# Install Telegram
##
ubuntu_install_telegram() {
    flathub_install "org.telegram.desktop"
}

##
# @Description
# Install Discord
# https://discord.com/
##
ubuntu_install_discord() {
    URL="https://discord.com/api/download?platform=linux&format=deb"
    deb_download_and_install "$URL"
}

##
# @Description
# Install TeamViewer
# https://www.teamviewer.com/es/download/linux/
##
ubuntu_install_teamviewer() {
    URL_DEB="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"
    deb_download_and_install "$URL"
}

##
# @Description
# Install GNU Image Manipulation Program
##
ubuntu_install_gimp() {
    apt_get_install "gimp"
}

##
# @Description
# Install Wireguard
# https://www.wireguard.com/install/
##
ubuntu_install_wireguard() {
    apt_get_install "wireguard"
}

################################################################################
#-- Hobbys --#
################################################################################

##
# @Description
# Install Lutris
##
ubuntu_install_lutris() {
    apt_get_install "lutris"
    # Install wine32 and arquitecture i386
    sudo dpkg --add-architecture i386
    sudo apt update
    apt_get_install "wine32:i386"
}

##
# @Description
# Install Steam
##
ubuntu_install_steam() {
    URL="https://cdn.akamai.steamstatic.com/client/installer/steam.deb"
    deb_download_and_install "$URL"
}

##
# @Description
# Install Heroic. Aggregator of games platforms
##
ubuntu_install_heroic() {
    # TODO install for all users
    flathub_install "com.heroicgameslauncher.hgl"
}

##
# @Description
# Install Minecraft
# https://www.minecraft.net/en-us/download/alternative
##
ubuntu_install_minecraft() {
    URL="https://launcher.mojang.com/download/Minecraft.deb"
    deb_download_and_install "$URL"
}

##
# @Description
# Install Chitubox software. Chitubox and Chitubox Manager.
##
ubuntu_install_chitubox_software() {
    # TODO install for all users
    echo_info "Manual install on "
    echo_info "https://www.chitubox.com/en/download/chitubox-free"
}

##
# @Description
# Install Lychee Slicer
##
ubuntu_install_lychee_slicer() {
    # TODO add to installations
    echo_info "Manual install on "    
    echo_info "https://lychee.mango3d.io/download-lychee-slicer"
}
