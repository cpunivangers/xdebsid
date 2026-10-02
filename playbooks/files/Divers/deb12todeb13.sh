#!/bin/bash

#https://fr.wikitwist.com/mettre-a-jour-debian-12-vers-debian-13-trixie-guide-pas-a-pas/
set -e
 
echo "🟡 Mise à jour de Debian 12 vers Debian 13 (Trixie)"
 
# 1. Vérification d'exécution en root
if [ "$(id -u)" -ne 0 ]; then
  echo "❌ Ce script doit être exécuté en tant que root."
  exit 1
fi
 
# 2. Affichage de la version actuelle
echo "📦 Version actuelle :"
cat /etc/os-release
 
# 3. Mise à jour complète de Debian 12
echo "🔄 Mise à jour du système actuel (Debian 12)..."
apt update && apt upgrade -y && apt full-upgrade -y
apt autoremove --purge -y
 
# 4. Sauvegarde de sources.list
echo "💾 Sauvegarde de /etc/apt/sources.list /etc/apt/sources.list.d"
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp -r /etc/apt/sources.list.d /etc//apt/sources.list.d12
 
# 5. Remplacement de 'bookworm' par 'trixie'
echo "✏️ Mise à jour des dépôts APT vers Debian 13"
sed -i 's/bookworm/trixie/g' /etc/apt/sources.list /etc/apt/sources.list.d/*
 
# 6. Mise à jour des paquets
echo "🆕 Mise à jour de la liste des paquets (Trixie)..."
apt update
 
# 7. Suppression de docker-compose-plugin pour éviter conflit
if dpkg -l | grep -q docker-compose-plugin; then
  echo "🚫 Suppression du package docker-compose-plugin (conflit connu)"
  dpkg --remove docker-compose-plugin || true
fi
# Suppression ntpdate remplacer par systemd-timesyncd
if ! ( apt-cache policy ntpdate | grep Installé | grep -q aucun ) ; then
	sudo apt-get -y purge ntpdate
fi
 
# 8. Mise à niveau minimale pour éviter les plantages
echo "🧩 Upgrade partiel sans nouveaux paquets..."
apt upgrade --without-new-pkgs -y
 
# 9. Full upgrade
echo "⚙️ Mise à niveau complète..."
apt full-upgrade -y
 
# 10. Nettoyage et réparation
echo "🧼 Nettoyage..."
apt -f install -y
apt autoremove --purge -y
apt clean
 
# 11. Affichage de la version finale
echo "✅ Version après mise à jour :"
cat /etc/os-release
 
# 12. Redémarrage
read -p "🔁 Redémarrer maintenant ? [y/N] " REBOOT
if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
  reboot
else
  echo "ℹ️ Redémarrage à faire manuellement plus tard."
fi
