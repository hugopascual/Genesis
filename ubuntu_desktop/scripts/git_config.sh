#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

#------------------------------- Config
git config --global user.email "hugopascual998@gmail.com"
git config --global user.name "hugopascual"   
