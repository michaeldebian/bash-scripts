#!/usr/bin/env bash

# Define progress bar parameters
bar_size=40
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2

# Function to display progress bar
function show_progress {
    local current="$1"
    local total="$2"

    # Calculate the progress in percentage 
    local percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    local done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    local todo=$(bc <<< "scale=0; $bar_size - $done" )

    # Build the done and todo sub-bars
    local done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    local todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # Output the bar
    echo -ne "\rProgress : [${done_sub_bar}${todo_sub_bar}] ${percent}%"

    if (( $(bc <<< "$current == $total") )); then
        echo -e "\nDONE"
    fi
}

# Function to execute script with progress bar
function execute_with_progress {
    local script_name=$1
    local script_command=$2
    local current=0
    local total=100 # Total progress
    echo "Starting $script_name..."
    eval "$script_command" >/dev/null 2>&1
    current=100
    show_progress "$current" "$total"
    echo "$script_name completed."
    echo "---------------------"
}

# Define commands for executing each script
script1_command="date" # Example command for script1
script2_command="free -m" # Example command for script2
script3_command="uptime" # Example command for script3
script4_command="ls" # Example command for script4

# Execute scripts concurrently with progress bar
execute_with_progress "Script 1" "$script1_command" &
execute_with_progress "Script 2" "$script2_command" &
execute_with_progress "Script 3" "$script3_command" &
execute_with_progress "Script 4" "$script4_command" &

# Wait for all processes to finish
wait