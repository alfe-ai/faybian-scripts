#!/bin/bash
set -e

# Replace this with the correct GPG fingerprint for Element
GPG_FINGERPRINT="0000000000000000000000000000000000000000"
KEYRING_PATH="/usr/share/keyrings/element-io-archive-keyring.gpg"
TMP_KEY="/tmp/element_key.asc"

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

echo "Installing dependencies..."
sudo apt install -y wget apt-transport-https

if [ -f "$KEYRING_PATH" ]; then
    echo "Verifying existing Element key fingerprint..."
    if ! verify_fingerprint "$KEYRING_PATH" "$EXPECTED_FPR"; then
        echo "Key fingerprint mismatch; re-downloading..."
        sudo rm -f "$KEYRING_PATH"
    else
        echo "Existing key fingerprint verified successfully."
    fi
fi

if [ ! -f "$KEYRING_PATH" ]; then
    echo "Element key not found or removed, fetching and adding..."
    sudo mkdir -p /usr/share/keyrings

    curl -fsSL https://packages.element.io/debian/element-io-archive-keyring.gpg -o "$TMP_KEY"

    echo "Verifying Element key fingerprint..."
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

echo "Adding Element repository..."
echo "deb [signed-by=$KEYRING_PATH] https://packages.element.io/debian/ default main" | sudo tee /etc/apt/sources.list.d/element-io.list

echo "Updating package list and installing Element Desktop..."
sudo apt update
sudo apt install -y element-desktop

