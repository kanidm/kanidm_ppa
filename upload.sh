#!/bin/bash

echo "Adding to the git index and doing the thing."

git reset HEAD
git add -A
git commit -m "Update $(date)"
git push -f
