#!/bin/sh
 
# 09/2025
# christian.pottier@univ-angers.fr

# oem install

OLD_LOGIN=$(id -un -- 1000)

source /etc/os-release

if [ "$OLD_LOGIN" = "oem" -o "$OLD_LOGIN" = "bonjour" ]; then

	mkdir -p /home/$OLD_LOGIN/.config/autostart
	echo "[Desktop Entry]\nType=Application\nExec=/opt/ansible/madeb$VERSION_ID/playbooks/files/oem-install/oem-install.sh" | tee /home/$OLD_LOGIN/.config/autostart/oem-install.desktop
	chmod +x /home/$OLD_LOGIN/.config/autostart/oem-install.desktop
fi
