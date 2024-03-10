#!/bin/bash

#------------------------------- Imports
# shellcheck source=/dev/null
source "../utils/auxiliar.sh"

# ------------------------------- Terminal
# Modify file .bashrc changing \w with \W
sed -iE 's/\\w/\\W/' ~/.bashrc