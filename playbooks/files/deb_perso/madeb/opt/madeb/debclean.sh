sudo apt clean
sudo apt autoclean
sudo apt autoremove $1
# Purge des fichiers de config restants
#sudo dpkg -P $(dpkg -l | grep '^rc' | awk '{ print $2 }')
