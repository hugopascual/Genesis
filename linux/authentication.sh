#!/bin/bash

# Load configuration
source "$1"

# GitHub Cli
gh auth login -h $GITHUB_USERNAME --with-token $GITHUB_TOKEN
