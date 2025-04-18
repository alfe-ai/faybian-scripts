#!/bin/bash

gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-right

gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-left

# For moving right
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Right', '<Alt><Control>Right', '<Alt><Super>Right']"

# For moving left
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Left', '<Alt><Control>Left', '<Alt><Super>Left']"

gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-right

gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-left
