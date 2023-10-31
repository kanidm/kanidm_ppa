#!/bin/bash

echo "Downloading $1"

curl -qLf -O "$1"

echo "Done!"
