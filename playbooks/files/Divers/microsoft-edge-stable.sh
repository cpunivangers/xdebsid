#!/bin/bash
 
# 30/09/2025
# christian.pottier@univ-angers.fr
# Installation Microsoft-edge
# curl -sL https://raw.githubusercontent.com/cpunivangers/madebNN/main/playbooks/files/Divers/microsoft-edge-stable.sh | bash
curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
sudo apt update
sudo apt -y install microsoft-edge-stable
# update-alternatives --display x-www-browser
echo "Force priorité microsoft-edge-stable à 10"
sudo update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/bin/microsoft-edge-stable 10
sudo update-alternatives --auto x-www-browser
sudo update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/microsoft-edge-stable 10
sudo update-alternatives --install /usr/bin/microsoft-edge microsoft-edge /usr/bin/microsoft-edge-stable 10
