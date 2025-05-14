#!/bin/bash

set -e

echo "🔧 Updating APT and installing prerequisites..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "📁 Creating keyrings directory..."
sudo install -m 0755 -d /etc/apt/keyrings

echo "🔑 Downloading Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "📦 Adding Docker APT repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating APT cache..."
sudo apt-get update -y

echo "🐳 Installing Docker Engine and plugins..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Verifying Docker installation..."
sudo docker run hello-world

echo "🎉 Docker installed and verified successfully!"
