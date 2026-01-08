#!/bin/bash

sudo_install() {
case $DISTRO_SELECTED in
    *)
        echo "$DISTRO_NOT_SUPPORTED_MESSAGE"
        ;;
esac
}