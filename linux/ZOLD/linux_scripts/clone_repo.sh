#!/bin/bash

##
# @Description
# Clone a GitHub repo in the proper dir config its locally username and email
# @Params
# $1 Username to sign commits
# $2 Email to sign commits
# $3 Organization or user who ows the repo
# $4 Repository name
##
clone_repo() {
    USERNAME="$1"
    EMAIL="$2"
    ORGANIZATION="$3"
    REPO_NAME="$4"

    REPO_DIR="$HOME/dev/$ORGANIZATION/$REPO_NAME"

    if [ ! -d "$HOME/dev/$ORGANIZATION/"  ]; then
        mkdir "$HOME/dev/$ORGANIZATION/" 
    fi
    git clone "https://github.com/$ORGANIZATION/$REPO_NAME" "$REPO_DIR"
    
    cd "$REPO_DIR" && git config user.name "$USERNAME"
    cd "$REPO_DIR" && git config user.email "$EMAIL"
}

clone_repo "$1" "$2" "$3" "$4"
