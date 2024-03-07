#!/bin/bash

# Define variables
DIR="/path/to/directory"
TOMCAT="apache-tomcat.tar.gz"
TOMCAT_DIR="/etc/init.d"
SERVER_IP=$(ip a | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v "127.0.0.1" | head -n1)

# Check if directory exists, otherwise create it
if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
fi

# Unzip js.zip file to directory DIR
unzip js.zip -d "$DIR"

# Make the file executable
chmod +x "$DIR/js"

# Change ownership recursively of the DIR directory to userid and group id mike
chown -R userid:mike "$DIR"

# Create a soft link from DIR/js file to /etc/init.d
ln -s "$DIR/js" /etc/init.d

# Untar file apache-tomcat.tar.gz to directory /usr/mike
tar -xzvf "$TOMCAT" -C /usr/mike

# Create a softlink that will point tomcat9 to apache-tomcat
ln -s /usr/mike/apache-tomcat /usr/mike/tomcat9

# Change ownership recursively to that directory to be owned by mike:mike
chown -R mike:mike /usr/mike/apache-tomcat

# Copy file tomcat from directory files/tomcat/tomcat to /etc/init.d
cp files/tomcat/tomcat "$TOMCAT_DIR"

# Change permissions of tomcat file to 755
chmod 755 "$TOMCAT_DIR/tomcat"

# Reload systemd daemon
systemctl daemon-reload

# Enable tomcat9 service
systemctl enable tomcat9

# Start tomcat9 service
systemctl start tomcat9

# Loop until no more permission denied errors are obtained
while grep -q "jsvc64" /var/log/messages; do
    cd /usr/local/src/policies
    audit2allow -M jsvc{01}pol -i /var/log/messages
    semodule -i jsvc{01}.pp
    ((counter++))
done

# Check if port 8080 is running
if netstat -vant | grep -q "8080"; then
    echo "Port 8080 is running."
    read -p "Please open up a browser and check http://$SERVER_IP:8080. Press Enter to continue..."
else
    echo "Port 8080 is not running."
fi

