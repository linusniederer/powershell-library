# PowerShell Library for daily use
Dieses Projekt beinhaltet eine PowerShell Bibliothek, welche den alltäglichen Umgang mit PowerShell erleichtern soll. In diesem README.md wird jede Funktion und ihre Parameter beschrieben.

### Inhaltsverzeichnis
1. Hyper-V 
2. Fehler Reporting
3. Loging von Skripts

## Hyper-V
In diesem Abschnitt befinden sich funktionen, welche zusammen mit Hyper-V benutzt werden können.


### Funktion: create-vm
Erstellt eine neue VM auf diesem Host.

`
create-vm
	[[-vmname] <String>]
    [[-type] <String>]
`

**Beispiel 1**

`get-vm-ipaddress -vmname "COMPUTERNAME" -type "IPv4"`

**Bemerkungen**

Je nach dem welcher Typ gewählt wird, wird das IPv4 oder das IPv6 Protokoll zurückgegeben. Die Funktion liefert die IPaddresse als Variable zurück, weshalb es Sinn macht, die Funktion direkt in eine Variable zu speichern.

---

### Funktion: get-vm-ipaddress
Liefert die Ip Adresse einer VM zurück, welche sich auf dem Host befindet.

`
get-vm-ipaddress
	[[-vmname] <String>]
    [[-type] <String>]
`

**Beispiel 1**

`get-vm-ipaddress -vmname "COMPUTERNAME" -type "IPv4"`

**Bemerkungen**

Je nach dem welcher Typ gewählt wird, wird das IPv4 oder das IPv6 Protokoll zurückgegeben. Die Funktion liefert die IPaddresse als Variable zurück, weshalb es Sinn macht, die Funktion direkt in eine Variable zu speichern.

---

