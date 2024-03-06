#!/usr/bin/env bash

# Define the list of Bash scripts to be executed
script_list=(
    "script1.sh"
    "script2.sh"
    "script3.sh"
    # Add more script names as needed
)

# Function to run a single script
run_script() {
    script="$1"
    echo "Executing $script..."
    bash "$script"
}

# Export the function so that xargs can use it
export -f run_script

# Run each script in parallel using xargs
printf "%s\n" "${script_list[@]}" | xargs -I {} -P 0 bash -c 'run_script "$@"' _ {}
