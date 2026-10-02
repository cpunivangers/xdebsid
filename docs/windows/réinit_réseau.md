# Ré initialiser le réseau

Powershell :

    netsh int IP reset
    ipconfig /flushdns
    ipconfig /release
    ipconfig /renew