#!/bin/bash

# Update apt
echo_info 'Upgrading and updating packages from APT'
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
echo_info "APT packages upgrades and updates finished"
