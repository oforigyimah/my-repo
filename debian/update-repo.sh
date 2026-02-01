#!/bin/bash
echo "Scanning packages..."
dpkg-scanpackages . /dev/null > Packages
gzip -9c Packages > Packages.gz

echo "Generating Release file..."
apt-ftparchive release . > Release

echo "Signing repository..."
rm -f InRelease Release.gpg
gpg --clearsign -o InRelease Release
gpg -abs -o Release.gpg Release

echo "Update complete. Don't forget to 'firebase deploy'!"
