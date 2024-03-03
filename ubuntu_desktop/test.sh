#!/bin/bash

#------------------------------- Imports
DIRECTORY=$(dirname "$0")

# DESKTOP_CONFIG_FILEPATH="$DIRECTORY/scripts/desktop_config.sh"
# shellcheck source=/dev/null
# source "$DESKTOP_CONFIG_FILEPATH"

INSTALLATIONS_FILEPATH="$DIRECTORY/utils/installations.sh"
# shellcheck source=/dev/null
source "$INSTALLATIONS_FILEPATH"

AUXILIAR_FILEPATH="$DIRECTORY/utils/auxiliar.sh"
# shellcheck source=/dev/null
source "$AUXILIAR_FILEPATH"

DIT_FILEPATH="$DIRECTORY/utils/dit.sh"
# shellcheck source=/dev/null
source "$DIT_FILEPATH"

#------------------------------- Test
install_openvpnc
