#!/usr/bin/env bash

file="requirements.txt"

# Check if the file exists
while [ ! -f "$file" ]; do
    echo "File $file not found. Waiting for the file to be present..."
    sleep 1
done

echo "File $file found. Continuing with the script."