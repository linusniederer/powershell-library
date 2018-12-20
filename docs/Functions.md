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
Mit Hilfe dieser Funktionen können so genannte Credentials erstellt werden, welche in PowerShell Skripts verwendet werden können.

### Funktion: create-credential
Erstellt eine Variable welche zum Beispiel bei Remotebefehlen verwendet werden kann.

```ps1
function create-credential (
    -user       "Benutzername"
    -password   "Passwort"
    -domain     "Domäne"
    -securefile "Pfad zum Sicherheitsfile"
)
```

**Bemerkungen**
Das Passwort kann in Klartext oder auch in Form eines Sicherheitsfiles mitgegeben werden.

### Funktion: create-credential-file
Mit Hilfe dieser Funktion kann ein Passwort einmalig in ein Sicherheitsfile gespeichert werden. Dies macht Sinn, wenn das Passwort nicht in Klartext mitgegeben werden soll.

```ps1
function create-credential-file (
    -password "Passwort"
    -filepath "Pfad zum Dokument"
)
```

**Bemerkungen**
Das Passwort muss in Klartext mitgegeben werden. Die Funktion erstellt nun eine Textdatei, welche bei anderen Funktionen verwendet werden kann.

## 2. Benutzeroberfläche
In diesem Abschnitt befinden sich Funktionen, mit welchen man Windows User Interfaces bauen kann.

### Funktion: create-form-window
Erstellt ein GUI, welches mit Form Objekten befüllt werden kann.

```ps1
function create-form-window (
    -text           "Titel des Fensters"
    -bgcolor        "Hintergrundfarbe"
    -startposition  "Startpunkt des Fensters"
    -icon           "Pfad zum Icon"
    -maximize       "Maximierungsbox"
    -height         "Höhe des Fensters"
    -widht          "Breite des Fensters"
)
```

**Bemerkungen**
Die gesammte Funktion muss in eine Variable gespeichert werden, damit sie später mit dem `ShowDialog()` angezeigt werden kann