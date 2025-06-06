#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <firefox-profile-path>"
  echo "Example: $0 \$HOME/.mozilla/firefox/yegl8wu8.default-esr"
  exit 1
fi

PROFILE_DIR="$1"

# 1. Create chrome directory and write userChrome.css
mkdir -p "$PROFILE_DIR/chrome"
cat > "$PROFILE_DIR/chrome/userChrome.css" <<'EOF'
/* Hide native top tabs toolbar */
#TabsToolbar {
  visibility: collapse !important;
}
EOF

# 2. Enable custom stylesheets in user.js
cat >> "$PROFILE_DIR/user.js" <<'EOF'
// Enable custom userChrome.css stylesheets
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
EOF

echo "✔ Firefox tab bar hiding configured in $PROFILE_DIR"
echo "→ Restart Firefox for changes to take effect"
