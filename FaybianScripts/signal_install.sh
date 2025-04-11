#!/bin/bash
set -e

KEYRING_PATH="/usr/share/keyrings/signal-desktop-keyring.gpg"

if [ ! -f "$KEYRING_PATH" ]; then
    echo "Signal Desktop key not found, fetching and adding..."
    sudo mkdir -p /usr/share/keyrings
    curl -fsSL https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor | sudo tee "$KEYRING_PATH" > /dev/null
else
    echo "Signal Desktop key already exists, skipping download."
fi

echo "Adding Signal Desktop repository..."
echo "deb [arch=amd64 signed-by=$KEYRING_PATH] https://updates.signal.org/desktop/apt stable main" | sudo tee /etc/apt/sources.list.d/signal-desktop.list

echo "Updating package list..."
sudo apt update

echo "Installing Signal Desktop..."
sudo apt install signal-desktop #-y
