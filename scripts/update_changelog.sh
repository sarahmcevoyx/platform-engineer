#!/bin/bash

# Extract the latest commit messages
new_changes=$(git log -1 --pretty=format:"%h - %s")

# Get the current date
current_date=$(date +'%Y-%m-%d')

# Create a new entry in the changelog
echo "## [Unreleased]" > new_changelog.md
echo "" >> new_changelog.md
echo "## [$current_date]" >> new_changelog.md
echo "### Changed" >> new_changelog.md
echo "- $new_changes" >> new_changelog.md
echo "" >> new_changelog.md

# Append the new changes to the existing changelog
cat CHANGELOG.md >> new_changelog.md

# Replace the old changelog with the new one
mv new_changelog.md CHANGELOG.md

# Add and commit the changes
git add CHANGELOG.md
git commit -m "Update CHANGELOG.md for $current_date"
