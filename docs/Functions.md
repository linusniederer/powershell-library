# PowerShell Funktionen Bibliothek

## Inhaltsverzeichnis
1. **[Hyper-V Management](#1-hyper-v-management)**
2. **[Authentifizierung](#2-authentifizierung)**
3. **[Benutzeroberfläche](#3-benutzeroberfläche)**
4. **[Loggen](#4-loggen)**
5. **[Datenbanken](#5-datenbanken)**

## 1. Hyper-V Management
In diesem Abschnitt befinden sich funktionen, welche zusammen mit Hyper-V benutzt werden können.

### Funktion: get-vm-ipaddress
Liefert die Ip Adresse einer VM zurück, welche sich auf dem Host befindet.

```ps1
get-vm-ipaddress
	[[-vmname] <String>]
    [[-type] <String>]
```