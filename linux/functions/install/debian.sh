#!/bin/bash

##
# @Description
# Basic installs that are proper from the distro only
##
base_install() {
    echo_installing 'Basic installs for this distribution'
    
    # Flatpak
    sudo apt-get install -y flatpak
    # add the Flathub repository
    FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
    sudo flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"

    echo_installing 'Basic installs for this distribution completed'
}

# Minimum ######################################################################

sudo_install() {
    echo_installing 'Installing sudo'
    #TODO: Install sudo
    echo_installing 'sudo installed'
}

htop_install() {
    echo_installing 'Installing htop'
    apt_get_install 'htop'
    echo_installing 'htop installed'
}

tree_install() {
    echo_installing 'Installing tree'
    apt_get_install 'tree'
    echo_installing 'tree installed'
}

nfs_install() {
    echo_installing 'Installing NFS utilities'
    apt_get_install 'nfs-common'
    echo_installing 'NFS utilities installed'
}

rename_install() {
    echo_installing 'Installing rename'
    apt_get_install 'rename'
    echo_installing 'rename installed'
}

rsync_install() {
    echo_installing 'Installing rsync'
    apt_get_install 'rsync'
    echo_installing 'rsync installed'
}

lshw_install() {
    echo_installing 'Installing lshw'
    apt_get_install 'lshw'
    echo_installing 'lshw installed'
}

wget_install() {
    echo_installing 'Installing wget'
    apt_get_install 'wget'
    echo_installing 'wget installed'
}

curl_install() {
    echo_installing 'Installing curl'
    apt_get_install 'curl'
    echo_installing 'curl installed'
}

vim_install() {
    echo_installing 'Installing vim'
    apt_get_install 'vim'
    echo_installing 'vim installed'
}

nvim_install() {
    echo_installing 'Installing nvim'
    apt_get_install 'nvim'
    echo_installing 'nvim installed'
}

fastfetch_install() {
    echo_installing 'Installing Fastfetch'
    # https://github.com/fastfetch-cli/fastfetch
    deb_download_and_install 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.de'
    echo_installing 'Fastfetch installed'
}

nvtop_install() {
    echo_installing 'Installing NVTop'
    apt_get_install 'nvtop'
    echo_installing 'NVTOP installed'
}

# Development ##################################################################

git_install() {
    echo_installing 'Installing Git'
    apt_get_install 'git'
    echo_installing 'Git installed'
}

github_cli_install() {
    # https://github.com/cli/cli/blob/trunk/docs/install_linux.md
    (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
}

jdk_install() {
    echo_installing 'Installing Java Development Kit'
    apt_get_install 'default-jdk'
    echo_installing 'Java Development Kit installed'
}

jre_install() {
    echo_installing 'Installing Java Runtime Environment'
    apt_get_install 'default-jre'
    echo_installing 'Java Runtime Environment installed'
}

docker_install() {
    echo_installing 'Installing Docker'
    # https://docs.docker.com/engine/install/debian/
    # Add Docker's official GPG key:
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
"Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt-get install -y docker-ce
    sudo apt-get install -y docker-ce-cli
    sudo apt-get install -y containerd.io
    sudo apt-get install -y docker-buildx-plugin
    sudo apt-get install -y docker-compose-plugin
    
    echo_installing 'Docker installed'
}

lazydocker_install() {
    echo_installing 'Installing lazydocker'
    # https://github.com/jesseduffield/lazydocker
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    sudo mv "$HOME/.local/bin/lazydocker" /usr/local/bin/
    echo_installing 'lazydocker installed'
}

python_install() {
    echo_installing 'Installing Python'
    apt_get_install 'python3'
    apt_get_install 'python3-venv'
    apt_get_install 'python3-pip'
    echo_installing 'Python installed'
}

nodejs_install() {
    echo_installing 'Installing NodeJS'
    # https://nodejs.org/es/download
    # Download and install nvm:
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    # Download and install Node.js:
    nvm install 24
    echo_installing 'NodeJS installed'
}

vscode_install() {
    echo_installing 'Installing Visual Studio Code'
    # https://code.visualstudio.com/docs/setup/linux
    deb_download_and_install 'https://go.microsoft.com/fwlink/?LinkID=760868'
    echo_installing 'Visual Studio Code installed'
}

jetbrains_toolbox_install() {
    echo_installing 'Installing JetBrains Toolbox'
    # https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
    # https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
    ## TODO install for all users
    ## TODO: improve with the build variable
    sudo apt-get install -y libfuse2
    jetbrains_toolbox_tar_file="jetbrains-toolbox-2.4.0.32175.tar.gz"
    wget -c https://download.jetbrains.com/toolbox/$jetbrains_toolbox_tar_file
    sudo tar -xzf "$jetbrains_toolbox_tar_file" -C /opt
    descompressed_dir="${jetbrains_toolbox_tar_file: : -7}"
    sudo /opt/"$descompressed_dir"/jetbrains-toolbox
    sudo rm -rf /opt/"$descompressed_dir"
    rm -f "$jetbrains_toolbox_tar_file"
    echo_installing 'JetBrains Toolbox installed'
}

postman_install() {
    echo_installing 'Installing Postman'
    # TODO: Install Postman
    echo_installing 'Postman installed'
}

raspberry_pi_imager_install() {
    echo_installing 'Installing Raspberry Pi Imager'
    apt_get_install 'rpi-imager'
    echo_installing 'Raspberry Pi Imager installed'
}

# DIT Software #################################################################

openvpn3_install() {
    echo_installing 'Installing OpenVPNv3'
    # https://community.openvpn.net/Pages/OpenVPN3Linux
    # https://openvpn.net/cloud-docs/tutorials/configuration-tutorials/connectors/operating-systems/linux/tutorial--learn-to-install-and-control-the-openvpn-3-client.html
    ## Install other necessary software
    sudo apt install -y apt-transport-https curl
    ## Repository keys
    sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://packages.openvpn.net/packages-repo.gpg | sudo tee /etc/apt/keyrings/openvpn.asc
    DISTRO=$(lsb_release -c -s)
    echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $DISTRO main" | sudo tee /etc/apt/sources.list.d/openvpn-packages.list
    sudo apt update
    sudo apt install -y openvpn3
    echo_installing 'OpenVPNv3 installed'
}

# Desktop ######################################################################

kitty_install() {
    echo_installing 'Installing kitty'
    #TODO: Install kitty
    echo_installing 'kitty installed'
}

displaylink_driver_install() {
    echo_installing 'Installing DisplayLink Driver'
    # https://www.synaptics.com/products/displaylink-graphics/downloads
    wget 'https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb'
    sudo apt install -y ./synaptics-repository-keyring.deb
    sudo apt update
    sudo apt install -y displaylink-driver
    rm synaptics-repository-keyring.deb
    echo_installing 'DisplayLink Driver installed'
}

firefox_install() {
    echo_installing 'Installing Firefox'
    apt_get_install 'firefox'
    echo_installing 'Firefox installed'
}

google_chrome_install() {
    echo_installing 'Installing Google Chrome'
    flathub_install 'com.google.Chrome'
    echo_installing 'Google Chrome installed'
}

thunderbird_install() {
    echo_installing 'Installing Thunderbird'
    flathub_install 'org.mozilla.Thunderbird'
    echo_installing 'Thunderbird installed'
}

keepassxc_install() {
    echo_installing 'Installing KeePass XC'
    flathub_install 'org.keepassxc.KeePassXC'
    echo_installing 'KeePass XC installed'
}

autofirma_install() {
    echo_installing 'Installing Autofirma'
    # https://firmaelectronica.gob.es/Home/Descargas.html
    curl -OL 'https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Debian.zip'
    unzip "Autofirma_Linux_Debian.zip"
    sudo apt install -y ./*.deb
    rm Autofirma*
    echo_installing 'Autofirma installed'
}

config_fnmt_install() {
    echo_installing 'Installing Config FNMT'
    # https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
    wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
    sudo apt install -y ./configuradorfnmt*
    rm configuradorfnmt*
    echo_installing 'Config FNMT installed'
}

obsidian_install() {
    echo_installing 'Installing Obsidian'
    deb_download_and_install 'https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb'
    echo_installing 'Obsidian installed'
}

vlc_install() {
    echo_installing 'Installing VLC'
    apt_get_install 'vlc'
    echo_installing 'VLC installed'
}

spotify_install() {
    echo_installing 'Installing Spotify'
    # https://www.spotify.com/us/download/linux/
    curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update
    sudo apt-get install -y spotify-client
    echo_installing 'Spotify installed'
}

telegram_install() {
    echo_installing 'Installing Telegram'
    flathub_install 'org.telegram.desktop'
    echo_installing 'Telegram installed'
}

discord_install() {
    echo_installing 'Installing Discord'
    deb_download_and_install 'https://discord.com/api/download?platform=linux&format=deb'
    echo_installing 'Discord installed'
}

teamviewer_install() {
    echo_installing 'Installing Team Viewer'
    deb_download_and_install 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'
    echo_installing 'Team Viewer installed'
}

gimp_install() {
    echo_installing 'Installing GIMP'
    apt_get_install 'gimp'
    echo_installing 'GIMP installed'
}

wireguard_install() {
    echo_installing 'Installing Wireguard'
    apt_get_install 'wireguard'
    echo_installing 'Wireguard installed'
}

7zip_install() {
    echo_installing 'Installing 7zip'
    apt_get_install '7zip'
    echo_installing '7zip installed'
}

# Hobbys #######################################################################

steam_install() {
    echo_installing 'Installing Steam'
    deb_download_and_install 'https://cdn.akamai.steamstatic.com/client/installer/steam.deb'
    echo_installing 'Steam installed'
}

minecraft_launcher_install() {
    echo_installing 'Installing Minecraft Launcher'
    # https://www.minecraft.net/en-us/download/alternative
    deb_download_and_install 'https://launcher.mojang.com/download/Minecraft.deb'
    echo_installing 'Minecraft Launcher installed'
}
