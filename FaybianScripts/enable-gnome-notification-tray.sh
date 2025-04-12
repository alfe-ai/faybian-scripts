#!/bin/bash
# Install and enable AppIndicator extension for notification tray
sudo apt-get install gnome-shell-extension-appindicator #-y
gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com']" 
#busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting GNOME Shell...")'
