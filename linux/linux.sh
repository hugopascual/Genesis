#!/bin/bash

## Constants
# Get the path to the main directory.
FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[0]}")"
LINUX_PATH="$(dirname "$FULL_PATH_TO_SCRIPT")"

## Parameters
ACTION="$1"

## Auxiliar functions
##
# @Description
#
# @Parameters
# $1 Directory to import scripts from
##
import_from_dir() {
    DIRECTORY="$1"
    # shellcheck disable=SC1090
    for file in $( find "$DIRECTORY" -type f -print | sort ); 
    do
        source "$file"
    done
}

## Import common utils
import_from_dir "$LINUX_PATH/utils"

## Select action to do
check_action "$ACTION"

## Ask for distribution
select_distribution

## Import distribution scripts
DISTRIBUTION_DIR="$LINUX_PATH/$DISTRIBUTION_SELECTED"
import_from_dir "$DISTRIBUTION_DIR/installations"
import_from_dir "$DISTRIBUTION_DIR/scripts"
