#!/bin/bash
# Install and enable AppIndicator extension for notification tray
sudo apt-get install gnome-shell-extension-appindicator -y
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com']"
