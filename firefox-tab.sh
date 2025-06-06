#!/usr/bin/env bash
set -euo pipefail

# 1. Find the default profile directory
INI="$HOME/.mozilla/firefox/profiles.ini"
# Read the first profile with Default=1 (default profile)
PROFILE_SECTION=$(awk '/\[/ { section=$0 } /Default=1/ { print section; exit }' "$INI")
# Extract Path and IsRelative for that section
PROFILE_PATH=$(awk -v sec="$PROFILE_SECTION" '
  $0==sec { insec=1; next }
  insec && /^Path=/ { print substr($0,6); exit }
' "$INI")
IS_RELATIVE=$(awk -v sec="$PROFILE_SECTION" '
  $0==sec { insec=1; next }
  insec && /^IsRelative=/ { print substr($0,12); exit }
' "$INI")

if [[ "$IS_RELATIVE" -eq 1 ]]; then
  PROFILE_DIR="$HOME/.mozilla/firefox/$PROFILE_PATH"
else
  PROFILE_DIR="$PROFILE_PATH"
fi

# 2. Create chrome directory and userChrome.css
mkdir -p "$PROFILE_DIR/chrome"
cat > "$PROFILE_DIR/chrome/userChrome.css" <<'EOF'
/* Hide native top tabs toolbar */
#TabsToolbar {
  visibility: collapse !important;
}
EOF

# 3. Enable legacy user stylesheet loading via user.js
cat >> "$PROFILE_DIR/user.js" <<'EOF'
// Enable custom userChrome.css stylesheets
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
EOF

echo "✔ Firefox tab bar hiding configured in $PROFILE_DIR"
echo "→ Restart Firefox for changes to take effect"
