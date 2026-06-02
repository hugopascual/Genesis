#!/bin/bash

###########################
#--Other Usage Functions--#
###########################
##
# @Description
# $1 Option to check
# $2 Error message to show if option not supported
# $3 Supported options list
##
check_option_supported() {
    option="$1"
    error_message="$2"
    local supported_options=("${@:3}")

    if [[ ! " ${supported_options[*]} " =~ [[:space:]]${option}[[:space:]] ]]; then
        echo "$error_message"
        help
    fi
}

##
# @Description
# Validate that a required value is not empty.
# @Params
# $1 Value to validate
# $2 Error message to display
##
check_required_value() {
    local value="$1"
    local error_message="$2"

    if [[ -z "$value" ]]; then
        echo "$error_message"
        help
    fi
}

##
# @Description
# Ensure a distro key is not already present in any package JSON file.
# @Params
# $1 Distro key to validate (e.g. fedora)
##
check_distro_not_included_in_packages() {
    local distro="$1"
    local package_files=("$PACKAGES_PATH"/*.json)

    if [[ ! -e "${package_files[0]}" ]]; then
        echo "No package JSON files found in $PACKAGES_PATH"
        exit 1
    fi

    if ! command -v jq &> /dev/null; then
        echo "jq is required to validate package JSON files"
        exit 1
    fi

    local existing_count=0
    local total_count=0

    for package_file in "${package_files[@]}"; do
        ((total_count++))
        if jq -e --arg distro "$distro" 'has($distro)' "$package_file" > /dev/null; then
            ((existing_count++))
        fi
    done

    if [[ $existing_count -gt 0 ]]; then
        echo "$DISTRO_ALREADY_INCLUDED_MESSAGE ($existing_count/$total_count)"
        exit 1
    fi
}

##
# @Description
#
##
check_command_installed(){
    command="$1"

    if ! command -v "$command" &> /dev/null; then
        echo "Command $command not installed"
        return 1
    fi

    return 0
}
