#!/bin/bash

# Set the root directory as the directory where the script is located
root_directory="$(cd "$(dirname "$0")" && pwd)"

# Change to the root directory
cd "$root_directory"

# Function to check for Dockerfile and print folder name
check_subfolders() {
  for folder in */; do
    if [ -f "$folder/Dockerfile" ]; then
      echo "$folder"
    fi
  done
}

# Check inside each sub-folder
check_subfolders