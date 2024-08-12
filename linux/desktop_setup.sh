#!/bin/bash

# Distributions available
DEBIAN_DISTROS=("ubuntu" "debian" "raspberryPi")
ARCH_DISTROS=("arch" "manjaro")

DISTROS=("${DEBIAN_DISTROS[@]}" "${ARCH_DISTROS[@]}")

# Select the distibution in which we are working to start the configuration
SELECT_DISTRO_MESSAGE=$'Enter the linux distribution which desktop you wants to setup: \n'
DISTROS_AVAILABLE_MESSAGE='The following distributions are avalibles on setup'
SELECTED_DISTRO_MESSAGE='The selected distribution is'
NOT_VALID_DISTRO_MESSAGE='The selected distribution is not valid'

echo "$DISTROS_AVAILABLE_MESSAGE"
for DISTRO in "${DISTROS[@]}"; do
    echo "$DISTRO"
done

read -rp "$SELECT_DISTRO_MESSAGE" SELECTED_DISTRO

echo "$SELECTED_DISTRO_MESSAGE $SELECTED_DISTRO"

if [[ ! " ${DISTROS[*]} " =~ [[:space:]]${SELECTED_DISTRO}[[:space:]] ]]; then
    # Message when array doesn't contain a valid distribution
    echo "$NOT_VALID_DISTRO_MESSAGE"
    exit 1
fi

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
LINUX_DIR="$(dirname "$FULL_PATH_TO_SCRIPT")"
# Files to import
FUNCTIONS_DIR="$LINUX_DIR/common_functions/"
SCRIPTS_DIR="$LINUX_DIR/common_scripts/"

# Import utils
# shellcheck disable=SC1090
for f in $( find "$FUNCTIONS_DIR" -type f -print | sort ); do source "$f"; done

#------------------------------- Start with the setup
echo_info "Starting setup"

#------------------------------- Update and Upgrade
"$SCRIPTS_DIR"update_system.sh

#------------------------------- Customization
"$SCRIPTS_DIR"desktop_config.sh
"$SCRIPTS_DIR"locales_config.sh

#------------------------------- Software installations
# Basic


# Development


# Services


# Extra


# DIT


# Games

#------------------------------- Software configuration

#------------------------------- Update and Clean
"$SCRIPTS_DIR"update_system.sh

#------------------------------- Finish
echo_success "Restart the computer now"