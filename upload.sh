#!/bin/bash

echo "Adding to the git index and doing the thing."

if [ "$(git status | grep -c 'nothing to commit' )" -eq 1 ]; then
  echo "Nothing to commit."
  exit 0
fi

git reset HEAD
git add -A
git commit -m "Update $(date)"
git push -f
