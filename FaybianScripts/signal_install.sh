#!/bin/bash
set -e

echo "Fetching and adding Signal Desktop GPG key..."
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://updates.signal.org/desktop/apt/keys.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo "Adding Signal Desktop repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt stable main" | sudo tee /etc/apt/sources.list.d/signal-desktop.list

echo "Updating package list..."
sudo apt update

echo "Installing Signal Desktop..."
sudo apt install signal-desktop #-y