#!/bin/bash

echo "Downloading $1"

FILENAME="$(basename "$1")"

if [ -f "$FILENAME" ]; then
    echo "File $FILENAME already exists!"
else
    echo "Downloading $FILENAME"
    curl -qLf -O "$1"
fi


echo "Done!"
