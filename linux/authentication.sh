#!/bin/bash

# Load configuration file
source "$1"

# GitHub Cli
gh auth login -h $GITHUB_USERNAME --with-token $GITHUB_TOKEN
# Clone repositories