# Kanidm PPA

This pulls the packages from [the Kanidm debs releases](https://github.com/kanidm/kanidm/releases/tag/debs) and makes a package archive for "nightly" packages. Packages are distributed for the latest LTS versions, Ubuntu 22.04 & Debian 12.

## Adding it to your system

The below commands:

1. Sets pipefail so that failures are caught.
2. Makes sure you have a "trusted GPG" directory.
3. Downloads the Kanidm PPA GPG public key.
4. Adds the Kanidm PPA to your local APT configuration, with autodetection of Ubuntu vs. Debian.
5. Updates your local package cache.

``` shell
set -o pipefail
sudo mkdir -p /etc/apt/trusted.gpg.d/
curl -s --compressed "https://kanidm.github.io/kanidm_ppa/KEY.gpg" \
    | gpg --dearmor \
    | sudo tee /etc/apt/trusted.gpg.d/kanidm_ppa.gpg >/dev/null

sudo curl -s --compressed "https://kanidm.github.io/kanidm_ppa/kanidm_ppa.list" \
    | grep $( ( . /etc/os-release && echo $ID) ) \
    | sudo tee /etc/apt/sources.list.d/kanidm_ppa.list
sudo apt update
```

## Listing packages

Use `apt-cache` to list the packages available:

```shell
apt-cache search kanidm
```
