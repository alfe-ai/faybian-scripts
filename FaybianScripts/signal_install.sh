#!/bin/bash
set -e

GPG_FINGERPRINT="DBA36B5181D0C816F630E889D980A17457F6FB06"
KEYRING_PATH="/usr/share/keyrings/signal-desktop-keyring.gpg"
TMP_KEY="/tmp/signal_key.asc"

verify_fingerprint() {
    local key_file="$1"
    local expected_fpr="$2"
    local actual_fpr

    actual_fpr=$(gpg --show-keys --with-colons "$key_file" | grep '^fpr:' | head -n1 | cut -d: -f10 | tr '[:upper:]' '[:lower:]')
    if [ "$actual_fpr" != "$expected_fpr" ]; then
        return 1
    fi
    return 0
}

EXPECTED_FPR=$(echo "$GPG_FINGERPRINT" | tr '[:upper:]' '[:lower:]')

if [ -f "$KEYRING_PATH" ]; then
    echo "Verifying existing Signal Desktop key fingerprint..."
    if ! verify_fingerprint "$KEYRING_PATH" "$EXPECTED_FPR"; then
        echo "Key fingerprint mismatch; re-downloading..."
        sudo rm -f "$KEYRING_PATH"
    else
        echo "Existing key fingerprint verified successfully."
    fi
fi

if [ ! -f "$KEYRING_PATH" ]; then
    echo "Signal Desktop key not found or removed, fetching and adding..."
    sudo mkdir -p /usr/share/keyrings

    curl -fsSL https://updates.signal.org/desktop/apt/keys.asc -o "$TMP_KEY"

    echo "Verifying Signal Desktop key fingerprint..."
    if ! verify_fingerprint "$TMP_KEY" "$EXPECTED_FPR"; then
        DOWNLOADED_FPR=$(gpg --show-keys --with-colons "$TMP_KEY" | grep '^fpr:' | head -n1 | cut -d: -f10 | tr '[:upper:]' '[:lower:]')
        echo "Error: Expected fingerprint $GPG_FINGERPRINT but got $DOWNLOADED_FPR"
        rm -f "$TMP_KEY"
        exit 1
    fi
    echo "Fingerprint verified successfully."

    sudo gpg --dearmor < "$TMP_KEY" | sudo tee "$KEYRING_PATH" > /dev/null
    rm -f "$TMP_KEY"
fi

echo "Adding Signal Desktop repository..."
echo "deb [arch=amd64 signed-by=$KEYRING_PATH] https://updates.signal.org/desktop/apt stable main" | sudo tee /etc/apt/sources.list.d/signal-desktop.list

echo "Updating package list..."
sudo apt update

echo "Installing Signal Desktop..."
sudo apt install signal-desktop
