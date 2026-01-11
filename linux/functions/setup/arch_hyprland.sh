#!/bin/bash

# Install hyprland desktop and the around software used
## First of all the around software used for som functionalities 
pacman_install 'qt5-wayland'
pacman_install 'qt6-wayland'
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


# Startup and login configuration with greetd
pacman_install 'greetd'
pacman_install 'greetd-tuigreet'
rsync -azP --delete "$STATICS_PATH/$DISTRO_PLUS_TYPE/greetd" '/etc/greetd'


# Waybar
pacman_install 'waybar'
# https://github.com/sejjy/mechabar
git clone https://github.com/sejjy/mechabar.git ~/.config/waybar
# shellcheck disable=SC1090
source ~/.config/waybar/install.sh


# Home folders configuration
for home_user_path in $( find /home -maxdepth 1 -mindepth 1 -type d  | sort ); 
do
    # Create development folders
    mkdir -p "$home_user_path/devops/repos"
    mkdir -p "$home_user_path/devops/docker_volumes"
    rsync -azP --delete "$STATICS_PATH/clone.sh" "$home_user_path/devops/repos/"
    
    # Copy configuration folders
    folders_to_copy=('kitty' 'yazi' 'hypr' 'wofi')
    for folder in "${folders_to_copy[@]}";
    do
        rsync -azP --delete "$STATICS_PATH/$DISTRO_PLUS_TYPE/$folder" "$home_user_path/.config/$folder"
    done

    # Add aliases to .bashrc
    echo "alias ll='ls -alF'
    alias bkhypr='rsync -azP ~/.config/hypr ~/arch_hypr/'
    alias bkwaybar='rsync -azP ~/.config/waybar ~/arch_hypr/'
    " >> "$home_user_path/.bashrc" 
done
