#!/bin/bash

##
# @Description
# 
##
execute_server_customization() {
    echo "execute_server_customization"
    config_locale
    config_bash
}

##
# @Description
# 
##
config_locale() {
    sudo locale-gen es_ES.UTF-8
    localectl set-locale LANG=en_US.UTF-8
    localectl set-locale LANGUAGE=en_US.UTF-8
    localectl set-locale LC_CTYPE=es_ES.UTF-8
    localectl set-locale LC_NUMERIC=es_ES.UTF-8
    localectl set-locale LC_TIME=es_ES.UTF-8
    localectl set-locale LC_COLLATE=es_ES.UTF-8
    localectl set-locale LC_MONETARY=es_ES.UTF-8
    localectl set-locale LC_MESSAGES=es_ES.UTF-8
    localectl set-locale LC_PAPER=es_ES.UTF-8
    localectl set-locale LC_NAME=es_ES.UTF-8
    localectl set-locale LC_ADDRESS=es_ES.UTF-8
    localectl set-locale LC_TELEPHONE=es_ES.UTF-8
    localectl set-locale LC_MEASUREMENT=es_ES.UTF-8
    localectl set-locale LC_IDENTIFICATION=es_ES.UTF-8
    localectl set-locale LC_ALL=es_ES.UTF-8
}

##
# @Description
# 
##
config_bash(){
    # Modify file .bashrc changing \w with \W
    sed -iE 's/\\w/\\W/' ~/.bashrc
}