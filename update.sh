#!/bin/bash

set -e
# Pulls the latest release files

if [ -z "${GPG_KEY_ID}" ]; then
    echo "Ensure the GPG_KEY_ID environment variable is set!"
    exit 1
fi

if [ "$(gpg --list-keys | grep -c "${GPG_KEY_ID}")" -ne 1 ]; then
    echo "Don't have GPG key ${GPG_KEY_ID}, can't continue!"
    exit 1
fi

if [ "$(which jq | wc -l )" -eq 0 ]; then
    echo "jq not found, please install jq"
    exit 1
fi

if [ "$(which curl | wc -l )" -eq 0 ]; then
    echo "curl not found, please install curl"
    exit 1
fi

if [ "$(which git-lfs | wc -l )" -eq 0 ]; then
    echo "git-lfs not found, please install git-lfs"
    exit 1
fi

cd ubuntu || exit 1

if [ -z "${SKIP_DOWNLOAD}" ]; then
    echo "Grabbing the Kanidm releases url"
    RELEASE_URL="$(curl -qs https://api.github.com/repos/kanidm/kanidm/releases | jq '.[] | select(.tag_name=="debs") | .assets_url')"

    if [ -z "${RELEASE_URL}" ]; then
        echo "Failed to get release url"
        exit 1
    fi

    echo "Downloading files from ${RELEASE_URL}"
    curl -qfs https://api.github.com/repos/kanidm/kanidm/releases/127032542/assets | jq '.[] | .browser_download_url' | xargs -n1 curl -Lf -O
else
    echo "Skipping download..."
fi

echo "Running dpkg-scanpackages"
dpkg-scanpackages --multiversion . > Packages

echo "Compressing Packages"
gzip -k -f Packages

echo "Generating release file"
apt-ftparchive release . > Release

echo "Signing release file"
gpg --default-key "${GPG_KEY_ID}" -abs -o - Release > Release.gpg
gpg --default-key "${GPG_KEY_ID}" --clearsign -o - Release > InRelease

echo "Done!"