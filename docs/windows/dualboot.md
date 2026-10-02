# Dual Boot Debian Windows

## Modification defaut grub pour ajout boot Windows

	echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
	sudo os-prober
	sudo update-grub

## Ajout boot Debian sous Windows :
  
  cd c:\Windows\System32\
  bcdedit /set {bootmgr} path \EFI\Debian\shimx64.efi
  

