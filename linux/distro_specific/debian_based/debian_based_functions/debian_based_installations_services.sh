#!/bin/bash

##
# @Description
# Install Spotify
# https://www.spotify.com/us/download/linux/
##
install_spotify() {
    curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update 
    sudo apt-get install spotify-client
}

##
# @Description
# Install Telegram
##
install_telegram() {
    flathub_install "org.telegram.desktop"
}

##
# @Description
# Install Discord
# https://discord.com/
##
install_discord() {
    URL="https://discord.com/api/download?platform=linux&format=deb"
    deb_download_and_install "$URL"
}
