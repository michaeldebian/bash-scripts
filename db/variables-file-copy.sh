#!/usr/bin/env bash

# Source file to copy
source_file="source_file.txt"

# List of destination directories
dest_dirs=(
    "/path/to/destination/directory1"
    "/path/to/destination/directory2"
    "/path/to/destination/directory3"
    # Add more directories as needed
)

# Check if the source file exists
if [ ! -f "$source_file" ]; then
    echo "Error: Source file $source_file not found."
    exit 1
fi

# Loop through the destination directories and copy the file
for dest_dir in "${dest_dirs[@]}"; do
    # Check if the destination directory exists
    if [ ! -d "$dest_dir" ]; then
        echo "Error: Destination directory $dest_dir not found."
        continue
    fi

    # Copy the file to the destination directory
    cp "$source_file" "$dest_dir"
    if [ $? -eq 0 ]; then
        echo "File $source_file copied to $dest_dir"
    else
        echo "Error: Failed to copy $source_file to $dest_dir"
    fi
done