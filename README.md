# Kanidm PPA

This pulls the packages from [the Kanidm debs releases](https://github.com/kanidm/kanidm/releases/tag/debs) and makes a package archive for "nightly" packages.

## Adding it to your system

The below commands:

1. Makes sure you have a "trusted GPG" directory.
2. Downloads the Kanidm PPA GPG public key.
3. Adds the Kanidm PPA to your local APT configuration.
4. Updates your local package cache.

``` shell
sudo mkdir -p /etc/apt/trusted.gpg.d/
curl -s --compressed "https://kanidm.github.io/kanidm_ppa/KEY.gpg" \
    | gpg --dearmor \
    | sudo tee /etc/apt/trusted.gpg.d/kanidm_ppa.gpg >/dev/null

sudo curl -s --compressed -o /etc/apt/sources.list.d/kanidm_ppa.list \
    "https://kanidm.github.io/kanidm_ppa/kanidm_ppa.list"
sudo apt update
```

## Listing packages

Use `apt-cache` to list the packages available:

```shell
apt-cache search kanidm
```
