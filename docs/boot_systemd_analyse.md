Temps de demarrage :
sudo systemd-analyze
ou
sudo systemd-analyze time

Detail des temps :
sudo systemd-analyze blame

temps critiques
sudo systemd-analyze critical-chain


Graphe
sudo systemd-analyse plot > startup.svg