#!/bin/bash
if [ $# -lt  1 ]; then
    echo "$0 <commit message>"
    exit 1
fi
msg="$1"
git commit -m "$msg"
if [ $? -ne 0 ]; then
    echo "Commit failed"
    exit 1
fi
git push origin master
if [ $? -ne 0 ]; then
    echo "Push failed"
fi
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
# Go To Public folder
cd public
# Add changes to git.
git add .
# Commit changes.
git commit -m "$msg"
# Push source and build repos.
git push origin master
# Come Back up to the Project Root
cd ..