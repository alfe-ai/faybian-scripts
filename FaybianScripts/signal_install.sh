#!/bin/bash
set -e

GPG_FINGERPRINT="DBA36B5181D0C816F630E889D980A17457F6FB06"
KEYRING_PATH="/usr/share/keyrings/signal-desktop-keyring.gpg"
TMP_KEY="/tmp/signal_key.asc"

if [ ! -f "$KEYRING_PATH" ]; then
    echo "Signal Desktop key not found, fetching and adding..."
    sudo mkdir -p /usr/share/keyrings

    curl -fsSL https://updates.signal.org/desktop/apt/keys.asc -o "$TMP_KEY"

    echo "Verifying Signal Desktop key fingerprint..."
    DOWNLOADED_FPR=$(gpg --show-keys --with-colons "$TMP_KEY" | grep '^fpr:' | head -n1 | cut -d: -f10 | tr '[:upper:]' '[:lower:]')
    EXPECTED_FPR=$(echo "$GPG_FINGERPRINT" | tr '[:upper:]' '[:lower:]')
    if [ "$DOWNLOADED_FPR" != "$EXPECTED_FPR" ]; then
        echo "Error: Expected fingerprint $GPG_FINGERPRINT but got $DOWNLOADED_FPR"
        rm -f "$TMP_KEY"
        exit 1
    fi
    echo "Fingerprint verified successfully."

    sudo gpg --dearmor < "$TMP_KEY" | sudo tee "$KEYRING_PATH" > /dev/null
    rm -f "$TMP_KEY"
else
    echo "Signal Desktop key already exists, skipping download."
fi

# TODO: For Alfe:
# Update the code so that the fingerprint check is here,
# We want to check the fingerprint of /usr/share/keyrings/...

echo "Adding Signal Desktop repository..."
echo "deb [arch=amd64 signed-by=$KEYRING_PATH] https://updates.signal.org/desktop/apt stable main" | sudo tee /etc/apt/sources.list.d/signal-desktop.list

echo "Updating package list..."
sudo apt update

echo "Installing Signal Desktop..."
sudo apt install signal-desktop #-y
