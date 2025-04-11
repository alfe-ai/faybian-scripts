#!/bin/bash

# Add Signal Desktop repository
echo "Adding Signal Desktop repository..."
sudo tee /etc/apt/sources.list.d/signal-desktop.list << EOL
deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main
EOL

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

