#!/bin/bash

################################################################################
#-- Minimum --#
################################################################################

# sudo
# TODO: Install sudo
# htop
pacman_install 'htop'
# tree
pacman_install 'tree'
# NFS
# TODO: install nfs funcionalities
# rename
pacman_install 'perl-rename'
# rsync
pacman_install 'rsync'
# lshw
pacman_install 'lshw'
# wget
pacman_install 'wget'
# curl
pacman_install 'curl'
# vim
pacman_install 'vim'
# nvim
pacman_install 'nvim'
# Fastfetch
pacman_install 'fastfetch'
# NVtop
pacman_install 'nvtop'

# yay
pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

################################################################################
#-- Development --#
################################################################################

# Git
pacman_install 'git'
# GitHub Cli
pacman_install 'github-cli'
# Java Runtime and Java Development Kit
# https://wiki.archlinux.org/title/Java#OpenJDK
pacman_install 'jdk-openjdk'
# Docker
pacman_install 'docker'
pacman_install 'docker-compose'
systemctl enable docker.service
# Lazydocker
yay_install 'lazydocker'
# Python3
pacman_install 'python'
# NodeJS
## Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
## in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
## Download and install Node.js:
nvm install 24
# Visual Studio Code
pacman_install 'code'
# JetBrains Toolbox
# TODO: install JetBrains Toolbox
# https://www.jetbrains.com/help/toolbox-app/toolbox-app-silent-installation.html#tba_installation
# https://dev.to/jorgecastro/install-jetbrains-toolbox-on-linux-596n
# Postman
# TODO: install Postman
# https://www.geeksforgeeks.org/installation-guide/install-postman-on-arch-based-linux/
# Raspberry Pi Imager
# TODO: install Raspberry Pi Imager

################################################################################
#-- DIT Software --#
################################################################################

# OpenVPNv3
yay_install 'openvpn3'

################################################################################
#-- Desktop --#
################################################################################


# kitty
pacman_install 'kitty'
# DisplayLink Driver
yay_install 'displaylink'
# Firefox
pacman_install 'firefox'
# Google Chrome
yay_install 'google-chrome'
# Thunderbird
pacman_install 'thunderbrid'
# KeePassXC
pacman_install 'keepass'
# Autofirma
# TODO: install Autofirma
# Configurador FNMT
# TODO: install Configurador FNMT
# Obsidian
pacman_install 'obsidian'
# VLC
pacman_install 'vlc'
# Spotify
# TODO: install Spotify
# Telegram Desktop
# TODO: install Telegram Desktop
# Discord
# TODO: install Discord
# TeamViewer
# TODO: install TeamViewer
# GIMP
# TODO: install GIMP
# WireGuard
pacman_install 'wireguard-tools'
# 7zip
pacman_install '7zip'

################################################################################
#-- Hobbys --#
################################################################################

# Steam
# TODO: install Steam
# Minecraft
# TODO: install Minecraft

################################################################################
