#!/bin/bash
# Install dependencies for ProtonVPN notification tray icons
#sudo apt-get install gnome-shell-extension-appindicator gir1.2-appindicator3-0.1 indicator-application
sudo apt install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator
#gsettings set org.gnome.shell enabled-extensions "['appindicatorsupport@rgcjonas.gmail.com']"
#busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting GNOME Shell...")'

