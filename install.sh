#!/bin/sh
# Dynamic Shapet installer

set -e

REPO_URL="https://repo.ofori.dev"

echo "Fetching latest Shapet version info..."
PACKAGES_TXT=$(curl -fsSL "$REPO_URL/Packages")

# Extract the Filename line of the first 'Package: shapet' entry
DEB_PATH=$(echo "$PACKAGES_TXT" | awk '/^Package: shapet/{flag=1} flag && /^Filename: /{print $2; exit}')

if [ -z "$DEB_PATH" ]; then
    echo "Error: Could not find shapet package in the repo!"
    exit 1
fi

DEB_URL="$REPO_URL/$DEB_PATH"
TMP_DEB=$(mktemp -t shapet_XXXXXX.deb)

echo "Downloading $DEB_URL..."
curl -fSL "$DEB_URL" -o "$TMP_DEB"

echo "Installing Shapet..."
sudo dpkg -i "$TMP_DEB" || sudo apt-get install -f -y

echo "Cleaning up..."
rm -f "$TMP_DEB"

echo "Shapet installation complete!"
