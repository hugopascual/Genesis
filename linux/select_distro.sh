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

read -rp "$SELECT_DISTRO_MESSAGE" CHILD_DISTRO

echo "$SELECTED_DISTRO_MESSAGE $CHILD_DISTRO"

#------------------------------- Check distro valid and parent distro
if [[ ! " ${DISTROS[*]} " =~ [[:space:]]${CHILD_DISTRO}[[:space:]] ]]; then
    # Message when array doesn't contain a valid distribution
    echo "$NOT_VALID_DISTRO_MESSAGE"
    exit 1
fi

PARENT_DISTRO="none"
# Check if CHILD_DISTRO is in DEBIAN
if [[ " ${DEBIAN_DISTROS[*]} " =~ [[:space:]]${CHILD_DISTRO}[[:space:]] ]]; then
    PARENT_DISTRO="debian"
fi

# Check if CHILD_DISTRO is in ARCH
if [[ " ${ARCH_DISTROS[*]} " =~ [[:space:]]${CHILD_DISTRO}[[:space:]] ]]; then
    PARENT_DISTRO="arch"
fi

if [[ "$PARENT_DISTRO" = "none" ]]; then
    exit 1
fi

PARENT_DISTRO_DIR="$PARENT_DISTRO""_based"
PARENT_DISTRO_DIR_FUNCTIONS="$PARENT_DISTRO_DIR""_functions"
PARENT_DISTRO_DIR_SCRIPTS="$PARENT_DISTRO_DIR""_scripts"

CHILD_DISTRO_DIR_FUNCTIONS="$CHILD_DISTRO""_functions"
CHILD_DISTRO_DIR_SCRIPTS="$CHILD_DISTRO""_scripts"

#------------------------------- Imports
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
LINUX_PATH="$(dirname "$FULL_PATH_TO_SCRIPT")"
# Files to import
LINUX_FUNCTIONS_PATH="$LINUX_PATH/linux_functions"
LINUX_SCRIPTS_PATH="$LINUX_PATH/linux_scripts"

# Selected distribution paths
PARENT_DISTRO_PATH="$LINUX_PATH/distro_specific/$PARENT_DISTRO_DIR"
PARENT_DISTRO_FUNCTIONS_PATH="$PARENT_DISTRO_PATH/$PARENT_DISTRO_DIR_FUNCTIONS"
PARENT_DISTRO_SCRIPTS_DIR="$PARENT_DISTRO_PATH/$PARENT_DISTRO_DIR_SCRIPTS"

CHILD_DISTRO_PATH="$PARENT_DISTRO_PATH/$CHILD_DISTRO"
CHILD_DISTRO_FUNCTIONS_PATH="$CHILD_DISTRO_PATH/$CHILD_DISTRO_DIR_FUNCTIONS"
CHILD_DISTRO_SCRIPTS_DIR="$CHILD_DISTRO_PATH/$CHILD_DISTRO_DIR_SCRIPTS"

# Import linux functions
echo "Importing common linux functions"
# shellcheck disable=SC1090
for f in $( find "$LINUX_FUNCTIONS_PATH" -type f -print | sort ); do 
    echo "Importing $f"
    source "$f"
done

echo "Importing parent distro functions"
# shellcheck disable=SC1090
for f in $( find "$PARENT_DISTRO_FUNCTIONS_PATH" -type f -print | sort ); do 
    echo "Importing $f"
    source "$f"
done

echo "Importing child distro functions"
# shellcheck disable=SC1090
for f in $( find "$CHILD_DISTRO_FUNCTIONS_PATH" -type f -print | sort ); do 
    echo "Importing $f"
    source "$f"
done
