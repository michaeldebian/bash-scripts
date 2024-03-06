#!/usr/bin/env bash

# Check if firewalld is running and start it if inactive
if systemctl is-active --quiet firewalld; then
    echo "firewalld is running."
else
    echo "firewalld is inactive. Starting firewalld..."
    systemctl start firewalld
    if [ $? -eq 0 ]; then
        echo "firewalld is started."
    else
        echo "Failed to start firewalld."
        exit 1
    fi
fi

# Check if firewalld has ports 80 and 8080 opened
if firewall-cmd --list-ports | grep -q "80/tcp"; then
    echo "Port 80 is already opened."
else
    echo "Opening port 80 in firewalld..."
    firewall-cmd --zone=public --add-port=80/tcp --permanent
    firewall-cmd --reload
    echo "Port 80 is opened."
fi

if firewall-cmd --list-ports | grep -q "8080/tcp"; then
    echo "Port 8080 is already opened."
else
    echo "Opening port 8080 in firewalld..."
    firewall-cmd --zone=public --add-port=8080/tcp --permanent
    firewall-cmd --reload
    echo "Port 8080 is opened."
fi

# Enable the httpd service
echo "Enabling the httpd service..."
systemctl enable httpd

# Start the httpd service
echo "Starting the httpd service..."
systemctl start httpd

# Check if httpd is running
if systemctl is-active --quiet httpd; then
    echo "httpd service is running."
    server_ip=$(ip a | grep inet | grep -v "127.0.0.1" | awk '{print $2}' | cut -d "/" -f 1)
    echo "Please open a browser and go to http://$server_ip to check if the service is up and running."
else
    echo "Failed to start httpd service. Exiting..."
    exit 1
fi

# Prompt the user to press Enter to continue
read -p "Press Enter to continue..."

# Disable port 8080
echo "Disabling port 8080 in firewalld..."
firewall-cmd --zone=public --remove-port=8080/tcp --permanent
firewall-cmd --reload
echo "Port 8080 is disabled."