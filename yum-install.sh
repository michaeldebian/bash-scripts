#!/usr/bin/env bash

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    echo "Error: requirements.txt file not found."
    exit 1
fi

# Install software listed in requirements.txt
echo "Installing software listed in requirements.txt..."
while IFS= read -r package; do
    if [ -n "$package" ]; then
        echo "Installing $package..."
        yum install -y "$package"
        if [ $? -eq 0 ]; then
            echo "Successfully installed $package."
        else
            echo "Error: Failed to install $package."
        fi
    fi
done < "requirements.txt"

echo "All software installation completed."