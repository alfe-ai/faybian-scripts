#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <firefox-profile-path>"
  echo "Example: $0 \$HOME/.mozilla/firefox/yegl8wu8.default-esr"
  exit 1
fi

PROFILE_DIR="$1"
CHROME_DIR="$PROFILE_DIR/chrome"
CSS_FILE="$CHROME_DIR/userChrome.css"

mkdir -p "$CHROME_DIR"

# Append or create the CSS rule
cat >> "$CSS_FILE" <<'EOF'

/* Hide Tree Style Tab sidebar header */
#sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
  display: none;
}
EOF

echo "✔ CSS rule appended to $CSS_FILE"
echo "→ Restart Firefox for changes to take effect"
