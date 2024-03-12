#!/usr/bin/env bash

file="requirements.txt"
line_number=1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: $file not found."
    exit 1
fi

# Calculate the number of lines in the file
num_lines=$(wc -l < "$file")

# Calculate the number of lines per column
lines_per_column=$(( (num_lines + 1) / 2 ))

# Get the number of columns in the terminal
num_columns=$(tput cols)

# Calculate padding for centering the output
padding=$(( (num_columns - 4) / 2 ))

# Loop through the file and list items with numbers
while IFS= read -r item; do
    # Calculate padding for centering the item
    item_padding=$(( padding - ${#item} ))
    
    # Print the item with padding for centering
    printf "%*s %s" "$item_padding" "" "$line_number) $item"
    
    # Check if we need to move to the next column
    if (( line_number == lines_per_column )); then
        echo
    fi
    
    ((line_number++))
done < "$file"
