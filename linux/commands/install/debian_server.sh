#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

# sudo
# TODO: Install sudo
# htop
apt_get_install 'htop'
# tree
apt_get_install 'tree'
# NFS
apt_get_install 'nfs-common'
# rename
apt_get_install 'rename'
# rsync
apt_get_install 'rsync'
# lshw
apt_get_install 'lshw'
# wget
apt_get_install 'wget'
# curl
apt_get_install 'curl'
# vim
apt_get_install 'vim'
# nvim
apt_get_install 'nvim'
# Fastfetch
# https://github.com/fastfetch-cli/fastfetch
deb_download_and_install 'https://github.com/fastfetch-cli/fastfetch/releases/download/2.50.2/fastfetch-linux-amd64.de'
# NVTOP
apt_get_install "nvtop"

################################################################################
#-- Development --#
################################################################################

# Git
apt_get_install "git"
# GitHub Cli
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# shellcheck disable=SC2174
mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y
# Java Runtime Environment
apt_get_install "default-jre"
# Docker
# https://docs.docker.com/engine/install/ubuntu/
# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce
apt-get install -y docker-ce-cli
apt-get install -y containerd.io
apt-get install -y docker-buildx-plugin
apt-get install -y docker-compose-plugin
# Lazydocker
# https://github.com/jesseduffield/lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
mv "$HOME/.local/bin/lazydocker" /usr/local/bin/
# Python3
apt_get_install "python3"
apt_get_install "python3-venv"
apt_get_install "python3-pip"

################################################################################