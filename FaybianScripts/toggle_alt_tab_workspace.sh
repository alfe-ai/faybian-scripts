#!/bin/bash
#
# toggle_alt_tab_workspace.sh
# Toggles whether Alt+Tab is restricted to the current workspace in GNOME.
#
# Usage:
#   1) Make this script executable:
#        chmod +x toggle_alt_tab_workspace.sh
#   2) Run it:
#        ./toggle_alt_tab_workspace.sh
#
# It will check the current setting; if Alt+Tab is restricted,
# the script will revert to showing all workspaces. Otherwise,
# it will restrict Alt+Tab to the current workspace.

CURRENT_SETTING="$(gsettings get org.gnome.shell.app-switcher current-workspace-only)"

if [ "$CURRENT_SETTING" = "true" ]; then
    echo "Currently: Alt+Tab restricted to current workspace. Reverting to show all workspaces..."
    gsettings set org.gnome.shell.app-switcher current-workspace-only false
    echo "Done! Now Alt+Tab shows windows from ALL workspaces."
else
    echo "Currently: Alt+Tab shows windows from all workspaces. Restricting to current workspace..."
    gsettings set org.gnome.shell.app-switcher current-workspace-only true
    echo "Done! Now Alt+Tab is restricted to the current workspace only."
fi
