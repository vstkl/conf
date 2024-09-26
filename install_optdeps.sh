#!/bin/bash

# Function to get optional dependencies and install them
install_optional_deps() {
  package="$1"
  # Get optional dependencies, clean the output, and install them
  yay -Qi "$package" | grep -E '^\s*[0-z\-]*:' -o | sed -e 's/^\s*//' -e 's/://' | sort | uniq | xargs yay -Sy --noconfirm
}

# Check if at least one package is provided
if [ "$#" -eq 0 ]; then
  echo "Please provide at least one package name."
  exit 1
fi

# Loop over all the arguments (package names)
for package in "$@"; do
  echo "Installing optional dependencies for package: $package"
  install_optional_deps "$package"
done

echo $#
