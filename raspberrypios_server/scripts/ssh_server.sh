#!/bin/bash

#------------------------------- Imports
# shellcheck source=/dev/null
source "../utils/auxiliar.sh"

sudo apt-get install -y openssh-server
sudo systemctl enable ssh
sudo systemctl restart ssh
