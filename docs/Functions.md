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
function get-vm-ipaddress (
    -vmname "VM Name"
    -type   "IPv4 oder IPv6"
)
```

**Bemerkungen**

Je nach dem welcher Typ gewählt wird, wird das IPv4 oder das IPv6 Protokoll zurückgegeben. Die Funktion liefert die IPaddresse als Variable zurück, weshalb es Sinn macht, die Funktion direkt in eine Variable zu speichern.

## 2. Authentifizierung
In diesem Abschnitt befinden sich funktionen, welche zusammen mit Hyper-V benutzt werden können.
