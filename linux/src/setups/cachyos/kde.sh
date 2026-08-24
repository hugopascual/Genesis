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

# Multitasking.
## Dynamic virtual desktops
git clone https://github.com/maurges/dynamic_workspaces.git
cd dynamic_workspaces
kpackagetool6 --type KWin/Script --install .
kwriteconfig6 --file kwinrc --group Plugins --key dynamic_workspacesEnabled true
qdbus6 org.kde.KWin /KWin reconfigure
cd ..
rm -rf dynamic_workspaces

# Mouse and touchpad scroll direction
kwriteconfig6 --file kcminputrc --group Touchpad --key NaturalScroll false

# Notifications

# Add the baterry percentage show
# Difficult to make it because depends on an external plugin

# Keyboard shortcuts
## Change virtual desktops with Ctrl+Alt+Left/Right
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Left" "Ctrl+Alt+Left"
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch One Desktop to the Right" "Ctrl+Alt+Right"

kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 1" "Meta+1"
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 2" "Meta+2"
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 3" "Meta+3"
kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop 4" "Meta+4"

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
