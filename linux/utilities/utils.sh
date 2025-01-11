#!/bin/bash

##
# @Description
#
##
help_message() {
    echo \
"
Usage:  ./linux.sh install { TYPE }
or      ./linux.sh update

where   TYPE := { desktop | server }
"
    exit 1
}

##
# @Description
# Open a read action on terminal in order to obtain the linux distribution used
# in the system.
# @Result
# $distro_selected Distribution selected by the user between the available ones.
##
select_distribution() {
    distro_selected="None"

    select_distro_message=$'Enter the linux distribution which desktop you wants to setup: \n'
    available_distros_message='The following distributions are avalibles on setup'
    selected_distro_message='The selected distribution is'
    not_valid_distro_message='The selected distribution is not valid'

    echo "$available_distros_message"
    for distro in "${AVAILABLE_DISTROS[@]}"; do
        echo "$distro"
    done

    read -rp "$select_distro_message" distro_selected

    if [[ ! " ${AVAILABLE_DISTROS[*]} " =~ [[:space:]]${distro_selected}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$not_valid_distro_message"
        exit 1
    fi

    echo "$selected_distro_message $distro_selected"
}
