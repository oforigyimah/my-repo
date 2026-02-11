#!/usr/bin/env bash
set -euo pipefail

echo "Adding shapet GPG key..."
wget -qO - https://oforigyimah.github.io/my-repo/debian/public.key \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/shapet-archive-keyring.gpg >/dev/null

echo "Adding shapet APT source..."
echo "deb [signed-by=/usr/share/keyrings/shapet-archive-keyring.gpg] https://oforigyimah.github.io/my-repo/debian ./" \
  | sudo tee /etc/apt/sources.list.d/shapet.list

echo "Updating package lists..."
sudo apt update

echo "Installing shapet..."
sudo apt install -y shapet

echo "shapet installation complete."
