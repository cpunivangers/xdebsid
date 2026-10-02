---
title: Contrôle parental  
number-sections: true  
date: 09/11/23 14:30  
author: Christian Pottier  
licence: CC BY 4.0  
---

# Contrôle parental

***Ceci est un brouillon, toutes les solutions ne sont pas détaillées et non pas étaient testées.***

[https://doc.ubuntu-fr.org/tutoriel/comment_mettre_en_place_un_controle_parental](https://doc.ubuntu-fr.org/tutoriel/comment_mettre_en_place_un_controle_parental)

Pour info, pour supprimer le mot de passe de connexion d'un enfant (ex: baby)

	sudo passwd -d baby

## Solutions simples

### Changer les DNS

[https://www.sos-informatique13.com/astuces/internet/controle-parental](https://www.sos-informatique13.com/astuces/internet/controle-parental)

[https://www.justgeek.fr/changer-serveurs-dns-windows-mac-ou-linux-40817/](https://www.justgeek.fr/changer-serveurs-dns-windows-mac-ou-linux-40817/)

Vous pouvez :

- changer les DNS de votre Box
- configurer l'ordinateur globalement (/etc/resolv.conf)
- **créer des connexions réseaux différentes avec des DNS spécifiques pour certains utilisateurs (Décocher "Tous les utilisateur peuvent se connecter à ce réseau")**
- faire un mixte des possibilités.

Redémarrer l’ordinateur et vérifier les accès des utilisateurs.

### Contrôler le temps d'utilisation (en anglais)

[https://doc.ubuntu-fr.org/utilisateurs/bcag2/timekpr-next](https://doc.ubuntu-fr.org/utilisateurs/bcag2/timekpr-next)

Tuto : [https://fr.tipsandtrics.com/ubuntu-timekpr-controls-computer-access-763171](https://fr.tipsandtrics.com/ubuntu-timekpr-controls-computer-access-763171)

Installer le paquet **timekpr-next**

	sudo apt install timekpr-next


## Solution plus complexe : Installation CTparental

 [https://gitlab.com/ctparentalgroup/CTparental/-/blob/master/README.md?ref_type=heads](https://gitlab.com/ctparentalgroup/CTparental/-/blob/master/README.md?ref_type=heads)

Tutoriel : [https://www.numetopia.fr/installation-de-ctparental-et-configuration/](https://www.numetopia.fr/installation-de-ctparental-et-configuration/)


**Attention !** Les paquets suivants ne sont pas disponibles directement sous Debian 12. Après installation, ils ne seront pas mis à jour automatiquement par votre système, vous devrait le faire manuellement si nécessaire.

- Télécharger et installer la dépendance au paquet **dnscrypt-proxy** :

	[http://deb.debian.org/debian/pool/main/d/dnscrypt-proxy/](http://deb.debian.org/debian/pool/main/d/dnscrypt-proxy/)

		wget http://ftp.fr.debian.org/debian/pool/main/d/dnscrypt-proxy/dnscrypt-proxy_2.0.45+ds1-1.1+b4_amd64.deb
		sudo apt install ./dnscrypt-proxy_2.0.45+ds1-1.1+b4_amd64.deb

- Télécharger et installer le paquet **ctparental** qui vous convient.

	[https://gitlab.com/ctparentalgroup/CTparental/-/releases](https://gitlab.com/ctparentalgroup/CTparental/-/releases)

### Version minimal

- Télécharger et installer le paquet **ctparental-min-lighttpd** :

		wget https://gitlab.com/ctparentalgroup/CTparental/uploads/3551bc5df194814599d02c57b59074ff/ctparental-min-lighttpd_debian11_ubuntu21.10_5.1.10-1.0_all.deb
		sudo apt install ./ctparental-min-lighttpd_debian11_ubuntu21.10_5.1.10-1.0_all.deb

- Suppression version minimal :

		sudo apt purge ctparental-min-lighttpd
		sudo apt autoremove
	

### Version complète

- Télécharger et installer le paquet **ctparental-full-lighttpd** :

		wget https://gitlab.com/ctparentalgroup/CTparental/uploads/1057269850087c318e283d9c92182c35/ctparental-full-lighttpd_debian11_ubuntu21.10_5.1.11-1.0_all.deb
		sudo apt install ./ctparental-full-lighttpd_debian11_ubuntu21.10_5.1.10-1.0_all.deb

- Suppression version complète :

		sudo apt purge ctparental-full-lighttpd
		sudo apt autoremove

