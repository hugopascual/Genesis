#!/bin/bash

####################
#--Echo functions--#
####################
# Colors and more
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
BHIGreen='\033[1;92m' # Bold High Intensity Green
BHIYellow='\033[1;93m' # Bold High Intensity Green
BHICyan='\033[1;96m' # Bold High Intensity Cyan
NoColor='\033[0m'
echo_info() {
    echo -e "${BHICyan}$1${NoColor}"
}

echo_success() {
    echo -e "${BHIGreen}$1${NoColor}"
}

echo_other() {
    echo -e "${BHIYellow}$1${NoColor}"
}

echo_installing() {
    echo -e "${BHICyan}Installing $1${NoColor}"
}

echo_installed() {
    echo -e "${BHIGreen}$1 installed${NoColor}"
}


###################
#--Update System--#
###################
##
# @Description
# Update packages from Ubuntu repositories, Flatpak and Snap 
##
update() {
	echo_info 'Upgrading and updating packages'
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get full-upgrade -y
	sudo apt-get autoremove -y
	sudo apt-get autoclean -y
	echo_info "Packages upgrades and updates finished"
}

############
#--Others--#
############
##
# @Description
# Congif username and email of git
##
git_config() {
    git config --global user.email "hugopascual998@gmail.com"
    git config --global user.name "hugopascual"   
}
