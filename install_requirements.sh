#!/bin/bash

set -e

# Install required packages

echo "Updating apt and installing required packages..."
apt-get update && apt-get -y install \
    curl \
    jq \
    make \
    dpkg-dev \
    apt-utils \
    git-lfs \
    git \
    gnupg
