# Modul importieren
Import-Module .\library.psm1

# IP Adresse der VM auslesen
$vmip = get-vm-ipaddress -vmname "Computer01" -type "ipv4"