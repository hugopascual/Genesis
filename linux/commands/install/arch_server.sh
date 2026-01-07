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
# TODO: install rename
# rsync
pacman_install 'rsync'
# lshw
pacman_install 'lshw'
# wget
pacman_install 'wget'
# curl
pacman_install 'curl'
# Fastfetch
pacman_install 'fastfetch'
# NVtop
# TODO: install NVtop

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

################################################################################
