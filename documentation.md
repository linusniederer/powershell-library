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

**Bemerkungen** <br>
Je nach dem welcher Typ gewählt wird, wird das IPv4 oder das IPv6 Protokoll zurückgegeben. Die Funktion liefert die IPaddresse als Variable zurück, weshalb es Sinn macht, die Funktion direkt in eine Variable zu speichern.

**Verwendung** <br>
Ein Beispiel zur Verwendung dieser Funktion findest du hier:
https://github.com/linusniederer/powershell-library/blob/master/examples/get-vm-ipaddress.ps1

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

**Bemerkungen** <br>
Das Passwort kann in Klartext oder auch in Form eines Sicherheitsfiles mitgegeben werden.

**Verwendung** <br>
Ein Beispiel zur Verwendung dieser Funktion findest du hier:
https://github.com/linusniederer/powershell-library/blob/master/examples/create-credential.ps1

### Funktion: create-credential-file
Mit Hilfe dieser Funktion kann ein Passwort einmalig in ein Sicherheitsfile gespeichert werden. Dies macht Sinn, wenn das Passwort nicht in Klartext mitgegeben werden soll.

```ps1
function create-credential-file (
    -password "Passwort"
    -filepath "Pfad zum Dokument"
)
```

**Bemerkungen** <br>
Das Passwort muss in Klartext mitgegeben werden. Die Funktion erstellt nun eine Textdatei, welche bei anderen Funktionen verwendet werden kann.

**Verwendung** <br>
Ein Beispiel zur Verwendung dieser Funktion findest du hier:
https://github.com/linusniederer/powershell-library/blob/master/examples/create-credential-file.ps1

## 3. Benutzeroberfläche
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

**Bemerkungen** <br>
Die gesammte Funktion muss in eine Variable gespeichert werden, damit sie später mit dem `ShowDialog()` angezeigt werden kann.

**Verwendung** <br>
Ein Beispiel zur Verwendung dieser Funktion findest du hier:
https://github.com/linusniederer/powershell-library/blob/master/examples/create-form-window.ps1

### Funktion: create-form-object
Erstellt ein Objekt auf einem GUI welches zuvor erstellt wurde.

```ps1
function create-form-object (
    -form       "Variable des form-window"
    -type       "textbox, label, button, checkbox, picturebox, progressbar"
    -text       "Text"
    -value      "Wert"
    -height     "Höhe"
    -widht      "Breiete"
    -autosize   "Automatische Grösse"
    -enabled    "Aktiviert oder nicht"
    -color      "Farbe"
    -bgcolor    "Hintergrundfarbe"
    -font       "Schriftart und Grösse"
    -imagepath  "Pfad zum Bild"
    -xpos       "Abstand von oben"
    -ypos       "Abstand von links"
    -click      "Funktion welche beim Click ausgeführt wird"
    -dynamic    "Dynamische Rückgabe"
)
```

**Bemerkungen** <br>
Wird der Wert von `-dynamic` auf `$true` so liefert die Funktion ein Objekt zurück, welches im Skript weiter bearbeitet werden kann. Dies macht dann Sinn, wenn sich Text zum Beispiel von Buttons oder Labels ändern.

**Verwendung** <br>
Ein Beispiel zur Verwendung dieser Funktion findest du hier:
https://github.com/linusniederer/powershell-library/blob/master/examples/create-form-object.ps1
