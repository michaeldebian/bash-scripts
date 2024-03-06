#!/usr/bin/env bash

# Source and target directories
source_dir="/path/to/source_directory"
target_dir="/path/to/target_directory"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory '$source_dir' does not exist."
    exit 1
fi

# Check if target directory exists, if not, create it
if [ ! -d "$target_dir" ]; then
    echo "Target directory '$target_dir' does not exist. Creating..."
    mkdir -p "$target_dir"
    echo "Target directory '$target_dir' created."
fi

# Move files from source directory to target directory
echo "Moving files from '$source_dir' to '$target_dir'..."
for file in "$source_dir"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        target_file="$target_dir/$filename"
        if [ -f "$target_file" ]; then
            # If target file already exists, create backup with timestamp
            timestamp=$(date +%m%d%Y)
            backup_file="$target_dir/${filename}.${timestamp}"
            echo "Backing up existing file '$target_file' to '$backup_file'..."
            mv "$target_file" "$backup_file"
        fi
        echo "Moving file '$filename' to '$target_dir'..."
        mv "$file" "$target_dir"
    fi
done

echo "Files moved successfully."