# PowerShell Library for daily use
Dieses Projekt beinhaltet eine PowerShell Bibliothek, welche den alltäglichen Umgang mit PowerShell erleichtern soll. In diesem README.md wird jede Funktion und ihre Parameter beschrieben.

### Inhaltsverzeichnis
1. Hyper-V 
2. Fehler Reporting
3. Loging von Skripts

## Hyper-V
In diesem Abschnitt befinden sich funktionen, welche zusammen mit Hyper-V benutzt werden können.

### Funktion - get-vm-ipaddress()
Die Funktion get-vm-ipaddress() liefert die Ipadresse einer VM, ohne dass eine Netzwerkverbindung zu VM gemacht werden muss.

`get-vm-ipaddress( $vmname, $type )` 

Die Variable `$vmname` muss mit dem Namen der VM auf dem Host befüllt werden. Der Parameter Type akzeptiert folgende Werte:
- 'IPv4' oder '4'
- 'IPv6' oder '6'

Je nach dem welcher Typ gewählt wird, wird das IPv4 oder das IPv6 Protokoll zurückgegeben. Die Funktion liefert die IPaddresse als Variable zurück, weshalb es Sinn macht, die Funktion direkt in eine Variable zu speichern.