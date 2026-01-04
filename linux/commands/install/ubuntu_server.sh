#!/bin/sh

################################################################################
#-- Minimum --#
################################################################################

apt_get_install 'htop'
apt_get_install 'tree'
apt_get_install 'nfs-common'
apt_get_install 'rename'
apt_get_install 'rsync'
apt_get_install 'lshw'
apt_get_install 'wget'
apt_get_install 'curl'
apt_get_install 'net-tools'
apt_get_install 'software-properties-common'

# Fastfecth
# https://github.com/fastfetch-cli/fastfetch
deb_download_and_install 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.de'

# Flatpak
sudo apt install -y flatpak
# add the Flathub repository
FLATHUB_REPO_URI=https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO_URI"

################################################################################
#-- Development --#
################################################################################

apt_get_install "git"
apt_get_install "default-jre"
apt_get_install "python3"
apt_get_install "python3-venv"
apt_get_install "python3-pip"
apt_get_install "rpi-imager"

snap_install "postman"

# Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
deb_download_and_install 'https://go.microsoft.com/fwlink/?LinkID=760868'

# GitHub Cli
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

# Docker
# https://docs.docker.com/engine/install/ubuntu/
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y curl
sudo apt-get install -y ca-certificates
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
## Add the repository to Apt sources:
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

# Lazydocker 
# https://github.com/jesseduffield/lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
sudo mv "$HOME/.local/bin/lazydocker" /usr/local/bin/

# NodeJS
# https://nodejs.org/es/download
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22

# JetBrains Toolbox
# https://www.jetbrains.com/help/idea/installation-guide.html#toolbox
# https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux
## TODO install for all users
jetbrains_toolbox_tar_file="jetbrains-toolbox-2.4.0.32175.tar.gz"
wget -c https://download.jetbrains.com/toolbox/$jetbrains_toolbox_tar_file
sudo tar -xzf "$jetbrains_toolbox_tar_file" -C /opt
descompressed_dir="${jetbrains_toolbox_tar_file: : -7}"
sudo apt-get install -y libfuse2
/opt/"$descompressed_dir"/jetbrains-toolbox
sudo rm -rf /opt/"$descompressed_dir"
sudo rm -f "$tar_file"

################################################################################
#-- DIT Software --#
################################################################################

# OpenVPN
# https://community.openvpn.net/Pages/OpenVPN3Linux
## Install other necessary software
sudo apt install -y apt-transport-https curl
## Repository keys
mkdir -p /etc/apt/keyrings
curl -sSfL https://packages.openvpn.net/packages-repo.gpg > /tmp/openvpn.asc
sudo mv /tmp/openvpn.asc /etc/apt/keyrings/openvpn.asc
## TODO update to change DISTRIBUTION dynamically
DISTRIBUTION="noble"
cp /etc/apt/sources.list.d/openvpn3.list /tmp/openvpn3.list
echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian ${DISTRIBUTION} main" >> /tmp/openvpn3.list
sudo mv /tmp/openvpn3.list /etc/apt/sources.list.d/openvpn3.list
## Install OpenVPN
sudo apt update
sudo apt install -y openvpn3

################################################################################
#-- Desktop --#
################################################################################

apt_get_install "nvtop"
apt_get_install "terminator"
apt_get_install "firefox"
apt_get_install "vlc"
apt_get_install "gimp"
apt_get_install "wireguard"

flathub_install "com.google.Chrome"
flathub_install "org.mozilla.Thunderbird"
flathub_install "org.keepassxc.KeePassXC"
flathub_install "org.telegram.desktop"

# Obsidian
deb_download_and_install 'https://github.com/obsidianmd/obsidian-releases/releases/download/v1.6.7/obsidian_1.6.7_amd64.deb'
# Discord
deb_download_and_install 'https://discord.com/api/download?platform=linux&format=deb'
# TeamViewer
deb_download_and_install 'https://download.teamviewer.com/download/linux/teamviewer_amd64.deb'

# Spotify
# https://www.spotify.com/us/download/linux/
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# DisplayLink Driver
# https://www.synaptics.com/products/displaylink-graphics/downloads
wget 'https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb'
sudo apt install -y ./synaptics-repository-keyring.deb
sudo apt update
sudo apt install -y displaylink-driver
sudo rm synaptics-repository-keyring.deb

# Autofirma
# https://firmaelectronica.gob.es/Home/Descargas.html
echo_installing "AutoFirma"
curl -OL 'https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/autofirma19/Autofirma_Linux_Debian.zip'
unzip "Autofirma_Linux_Debian.zip"
sudo apt install -y ./*.deb
rm Autofirma*
echo_installed "AutoFirma"

# Configurador FNMT
# https://www.sede.fnmt.gob.es/descargas/descarga-software/instalacion-software-generacion-de-claves
echo_installing "Configurador FNMT"
sudo apt install -y default-jdk
wget https://descargas.cert.fnmt.es/Linux/configuradorfnmt_4.0.5_amd64.deb
sudo apt install -y ./configuradorfnmt*
rm configuradorfnmt*
echo_installed "Configurador FNMT"

################################################################################
#-- Hobbys --#
################################################################################

apt_get_install "lutris"

flathub_install "com.heroicgameslauncher.hgl"

# Steam
deb_download_and_install 'https://cdn.akamai.steamstatic.com/client/installer/steam.deb'
# Minecraft
# https://www.minecraft.net/en-us/download/alternative
deb_download_and_install 'https://launcher.mojang.com/download/Minecraft.deb'

################################################################################