#!/bin/bash

# Add Signal Desktop repository
echo "Adding Signal Desktop repository..."
sudo tee /etc/apt/sources.list.d/signal-desktop.list << EOL
deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main
EOL

# Retrieve GPG key for Signal Desktop repository
GPG_FINGERPRINT="DBA36B5181D0C816F630E889D980A17457F6FB06"
RECV_CMD="sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $GPG_FINGERPRINT"
echo "Retrieving GPG key with fingerprint $GPG_FINGERPRINT"
echo "Executing command: $RECV_CMD"
$RECV_CMD

# Update package list
echo "Updating package list..."
sudo apt update

# Install Signal Desktop
echo "Installing Signal Desktop..."
sudo apt install signal-desktop #-y

# Fix dependencies
#echo "Fixing dependencies..."
#sudo apt install -f

# Launch Signal Desktop (optional)
#echo "Starting Signal Desktop..."
#signal-desktop &
