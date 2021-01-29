#!/bin/bash
# Andromeda cluster bootstrap script

set -e
TOTAL_STEPS=10

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Check distribution
A_PLATFORM_RELEASE=$(lsb_release -sd)
if [[ ! $A_PLATFORM_RELEASE == "Debian GNU/Linux 10 (buster)" ]]; then
  echo "Detected incorrect host platform: $A_PLATFORM_RELEASE"
fi

echo "[1/$TOTAL_STEPS] Removing old packages..."
apt-get remove -y docker docker-engine docker.io containerd runc > /dev/null

echo "[2/$TOTAL_STEPS] Updating package cache..."
apt-get update > /dev/null

echo "[3/$TOTAL_STEPS] Installing docker prerequisites..."
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common > /dev/null

echo "[4/$TOTAL_STEPS] Adding docker GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

echo "[5/$TOTAL_STEPS] Adding docker repo..."
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"

echo "[6/$TOTAL_STEPS] Updating package cache..."
apt-get update > /dev/null

echo "[6/$TOTAL_STEPS] Installing docker..."
apt-get update > /dev/null
apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null

# Show docker version
docker -v
