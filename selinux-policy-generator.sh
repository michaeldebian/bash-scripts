#!/usr/bin/env bash

# Define the output directory
output_dir="/usr/local/myrepo"

# Iterate over the numbers from 1 to 7
for i in {1..7}; do
    # Generate the filename
    filename="looooopp0${i}.pip"
    
    # Check if the file exists
    if [ -f "$filename" ]; then
        # Print a message indicating the current file being processed
        echo "Processing file: $filename"
        
        # Run sepolicy generate --init for the current file
        sepolicy generate --init "$filename"
        
        # Print a message indicating the completion
        echo "Completed processing file: $filename"
        
        # Move the file to the output directory
        mv "$filename" "$output_dir/"
        
        # Print a message indicating the file has been moved
        echo "Moved $filename to $output_dir"
    else
        echo "File $filename does not exist."
    fi
done