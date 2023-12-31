#!/bin/bash

set -u

echo "Downloading from $1"

FILENAME="$(basename "$1")"

if [ -f "$FILENAME" ]; then
    echo "File $FILENAME already exists!"
else
    echo -n "Downloading to $FILENAME ... "
    curl -qsLf -O "$1" || exit 1
fi


echo "Done!"
