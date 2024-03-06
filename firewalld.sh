#!/usr/bin/env bash

# Check if firewalld is running
if systemctl is-active --quiet firewalld; then
    echo "firewalld is running."
else
    echo "firewalld is inactive. Starting it up..."
    # Start firewalld
    systemctl start firewalld
    echo "firewalld has been started."
fi

# Open ports 80 and 8080
echo "Opening ports 80 and 8080 in firewalld..."
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=8080/tcp --permanent
echo "Ports 80 and 8080 have been opened in firewalld."

# Reload firewalld to apply changes
echo "Reloading firewalld to apply changes..."
firewall-cmd --reload
echo "Firewalld has been reloaded."

# Get server's IP address
server_ip=$(ip a | awk '/inet /{print $2}' | grep -v '127.0.0.1' | cut -d'/' -f1)

# Prompt user to check a specific URL
echo "Please open your browser and go to: http://$server_ip:8080 to verify the changes."
