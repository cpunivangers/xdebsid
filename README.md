# Ma Debian Sid Xfce

Configuration d'un poste Debian Sid bureau XFCE avec ansible.

## Pré-requis

Installer **Debian-Facile 13.x** ou  Debian 13.x  

### Installation Debian-Facile (Le plus facile !)

Installer Debian-Facile, c'est une vraie Debian avec un bureau XFCE et une pré-configuration qui facilite son utilisation.  

Image iso : [https://debian-facile.org/dflinux/isos/](https://debian-facile.org/dflinux/isos/)

### ou installation de Debian 13

Installation Debian 13 avec l’image **debian-13.n.n-amd64-netinst.iso**  
[https://cdimage.debian.org/debian-cd/current/amd64/iso-cd](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd)

**ATTENTION pour une machine virtuelle Virtualbox, installer en BIOS mode, ne pas activer EFI**

- Pas de mot passe pour root (= mode sudo)
- Mettre Bureau **XFCE** à la place de GNOME
- Ajouter Serveur SSH (si vous voulez installer à distance la suite)

Se connecter sur le poste en SSH ou en **terminal [CTRL]+[ALT]+[F1]** 

## [Installation xdedbsid](docs/README/install.md)


## [ou Mise à niveau Debian 13 (madeb13) vers Debian Sid (xdebsid)](docs/README/upgrade.md)

