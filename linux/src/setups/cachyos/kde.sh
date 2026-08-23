#!/bin/bash

################################################################################
# Configure system locales

################################################################################
# Create basics folders structure 
desktop_folder_structure_creation

################################################################################
# Configure environment
selected_statics_path="$STATICS_PATH/$DISTRO_SELECTED/$OPTION_SELECTED"
copy_config_statics

#------------------------------- Appearance and general settings
# Style
lookandfeeltool -a org.kde.breezedark.desktop

# Background and screensaver 
plasma-apply-wallpaperimage "$HOME/.config/theme/background.jpg"

# Multitasking

# Mouse and touchpad scrool direction

# Notifications

# Add the baterry percentage show

################################################################
# Add second keyboard distribution

kwriteconfig6 --file kxkbrc --group Layout --key Use true
kwriteconfig6 --file kxkbrc --group Layout --key LayoutList "us,es"
kwriteconfig6 --file kxkbrc --group Layout --key Options "grp:win_space_toggle"

################################################################
# Startup applications
autostart_folder="$HOME/.config/autostart"
mkdir -p "$autostart_folder"
# Obsidian
cp /usr/share/applications/obsidian.desktop "$autostart_folder"
cp /usr/share/applications/org.mozilla.Thunderbird.desktop "$autostart_folder"
cp /usr/share/applications/firefox.desktop "$autostart_folder"

################################################################################
# Other setup configurations

aliases_setup

# .bashrc configuration and customization
sed -iE 's/\\w/\\W/' "$HOME/.bashrc"

################################################################################
# Graphics drivers
