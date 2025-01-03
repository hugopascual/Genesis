#!/bin/bash

##
# @Description
#
##
help() {
    echo \
"Ayuda"
}

##
# @Description
# Open a read action on terminal in order to obtain the linux distribution used
# in the system.
# @Result
# $DISTRIBUTION_SELECTED Distribution selected by the user between the available
# ones.
##
select_distribution() {
    DISTRIBUTIONS_AVAILABLE=(
        "ubuntu" "debian"
    )

    DISTRIBUTION_SELECTED="None"

    SELECT_DISTRIBUTION_MESSAGE=$'Enter the linux distribution which desktop you wants to setup: \n'
    DISTRIBUTION_AVAILABLE_MESSAGE='The following distributions are avalibles on setup'
    SELECTED_DISTRIBUTION_MESSAGE='The selected distribution is'
    NOT_VALID_DISTRIBUTION_MESSAGE='The selected distribution is not valid'

    echo "$DISTRIBUTION_AVAILABLE_MESSAGE"
    for DISTRIBUTION in "${DISTRIBUTIONS_AVAILABLE[@]}"; do
        echo "$DISTRIBUTION"
    done

    read -rp "$SELECT_DISTRIBUTION_MESSAGE" DISTRIBUTION_SELECTED

    if [[ ! " ${DISTRIBUTIONS_AVAILABLE[*]} " =~ [[:space:]]${DISTRIBUTION_SELECTED}[[:space:]] ]]; then
        # Message when array doesn't contain a valid distribution
        echo "$NOT_VALID_DISTRIBUTION_MESSAGE"
        exit 1
    fi

    echo "$SELECTED_DISTRIBUTION_MESSAGE $DISTRIBUTION_SELECTED"
}

##
# @Description
# 
# @Parameters
# $1 Action to take over the system
##
check_action() {
    ACTION="$1"
    echo "$ACTION"
}
