#!/usr/bin/env bash

# Read environment variables from environment.txt file
source "enviroment.txt"

# Function to print web server options
print_web_servers() {
    echo "Web Servers:"
    local count=1
    for var in ${!webserver@}; do
        echo "$count) ${!var}"
        ((count++))
    done
}

# Function to print database server
print_db_server() {
    echo "Database Server:"
    echo "${dbserver}"
}

# Function to add entry in /etc/hosts
add_to_etc_hosts() {
    local server_name="$1"
    local ip_address="$2"
    echo "$ip_address $server_name" | sudo tee -a /etc/hosts >/dev/null
}

# Function to change web server name using systemctl
change_web_server_name() {
    local server_name="$1"
    sudo systemctl set-hostname "$server_name"
}

# Main script
echo "Please select which server would you like to configure"

# Print available web servers
print_web_servers

# Prompt user to select a web server
read -p "Enter the number of the web server you want to configure: " selection

# Validate user selection
if (( selection >= 1 && selection <= ${#webserver[@]} )); then
    selected_web_server=${!webserver$selection}
    web_server_name=$(echo "$selected_web_server" | awk '{print $1}')
    web_server_ip=$(echo "$selected_web_server" | awk '{print $2}')

    # Add entry in /etc/hosts
    add_to_etc_hosts "$web_server_name" "$web_server_ip"
    echo "Entry added to /etc/hosts for $web_server_name ($web_server_ip)"

    # Print database server
    print_db_server

    # Add entry in /etc/hosts for database server
    db_server_ip=$(echo "$dbserver" | awk '{print $1}')
    db_server_name=$(echo "$dbserver" | awk '{print $2}')
    add_to_etc_hosts "$db_server_name" "$db_server_ip"
    echo "Entry added to /etc/hosts for database server $db_server_name ($db_server_ip)"

    # Change web server name using systemctl
    change_web_server_name "$web_server_name"
    echo "Web server name changed to $web_server_name"
else
    echo "Invalid selection. Please enter a valid number."
fi
