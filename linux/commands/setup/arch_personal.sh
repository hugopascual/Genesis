#!/bin/bash

# Install hyprland desktop and the around software used
## First of all the around software used for som functionalities 
pacman_install 'greetd'
pacman_install 'greetd-tuigreet'
pacman_install 'qt5-wayland'
pacman_install 'qt6-wayland'
pacman_install 'waybar'
pacman_install 'wofi'
pacman_install 'brightnessctl'
pacman_install 'swaync'
pacman_install 'yazi'
## Now we go with the proper hyprland software
pacman_install 'hyprland'
pacman_install 'hyprpaper'
pacman_install 'hypridle'
pacman_install 'hyprlock'
pacman_install 'xdg-desktop-portal-hyprland'
pacman_install 'hyprshot'
pacman_install 'hyprctl'


# Configuration
## Startup and login
rsync -azP --delete "$STATICS_PATH/$DISTRO_PLUS_TYPE/greetd" '/etc/greetd'
## Waybar
## https://github.com/sejjy/mechabar
git clone https://github.com/sejjy/mechabar.git ~/.config/waybar
# shellcheck disable=SC1090
source ~/.config/waybar/install.sh


# Home folders configuration
for home_user_path in $( find /home -maxdepth 1 -mindepth 1 -type d  | sort ); 
do
    mkdir -p "$home_user_path/development/repos"
    mkdir -p "$home_user_path/development/docker_volumes"
    folders_to_copy=('hypr' 'kitty' 'wofi' 'yazi')
    for folder in "${folders_to_copy[@]}";
    do
        rsync -azp --delete "$STATICS_PATH/$DISTRO_PLUS_TYPE/$folder" "$home_user_path/.config/$folder"
    done

    # Add alias to .bashrc
    echo "alias ll='ls -alF'
    alias bkhypr='rsync -azP ~/.config/hypr ~/arch_hypr/'
    alias bkwaybar='rsync -azP ~/.config/waybar ~/arch_hypr/'
    " >> ~/.bashrc
done
