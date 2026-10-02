# Installation driver dongle wifi RTL8811AU

pour :

	TP-Link AC600 wireless Realtek RTL8811AU [Archer T2U Nano]

Référence : [https://docs.alfa.com.tw/Support/Linux/RTL8811AU/](https://docs.alfa.com.tw/Support/Linux/RTL8811AU/)

	sudo apt install dkms
	sudo apt install rfkill
	sudo apt install git
	git clone https://github.com/morrownr/8821au-20210708.git
	cd 8821au-20210708/
	sudo ./install-driver.sh

Redémarrage ou débrancher et rebrancher le dongle

Vérification :

	inxi -N