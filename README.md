# PowerShell Library for daily use
Dieses Projekt beinhaltet eine PowerShell Bibliothek, welche den alltäglichen Umgang mit PowerShell erleichtern soll. In diesem README.md wird jede Funktion und ihre Parameter beschrieben.

### Inhaltsverzeichnis
1. Hyper-V
2. Authentifikation
3. User Interface

## Hyper-V
In diesem Abschnitt befinden sich funktionen, welche zusammen mit Hyper-V benutzt werden können.

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

## Authentifikation
In diesem Abschnitt befinden sich Funktionen, mit welchen man sich in einem PowerShell Skript authentifizieren kann.

### Funktion: create-credential
Erstellt eine Variable welche zum Beispiel bei Remotbefehlen verwendet werden kann.

`
create-credential
	[[-user] <String>]
    [[-domain] <String>]
    [[-password] <String>]
    [[-securefile] <String>]
`

**Beispiel 1**

`create-credential -user "Admin" -domain "git.local" -password "password123"`

**Bemerkungen**

Bei diesem Beispiel wird das Passwort in Klartext mitgegeben. Das ist Riskant, da jeder das Passwort mitlesen kann.

**Beispiel 2**

`create-credential -user "Admin" -domain "git.local" -securefile "C:\Admin\password.txt"`

**Bemerkungen**

In diesem Beispiel ist das Passwort nicht zu sehen, da es sich verschlüsselt in der password.txt befindet. Verschlüsselte Passwortdateien können mit der Funktion `create-credential-file` erstellt werden.

---

### Funktion: create-credential-file
Erstellt eine Variable welche zum Beispiel bei Remotbefehlen verwendet werden kann.

`
create-credential-file
    [[-password] <String>]
    [[-filepath] <String>]
`

**Beispiel 1**

`create-credential-file -password "password123" -filepath "C:\Temp\credentials.txt"`

**Bemerkungen**

Das Passwort muss in Klartext mitgegeben werden. Die Funktion erstellt nun eine Textdatei, welche bei anderen Funktionen verwendet werden kann. Dieser Teil muss nur einmal ausgeführt werden, nun kann die Textdatei immer wieder verwendet werden. Zum Beispiel mit der Funktion `create-credential`.

## User Interface
In diesem Abschnitt befinden sich Funktionen, mit welchen man Windows User Interfaces bauen kann.

### Funktion: create-form-window
Erstellt ein GUI, welches mit Form Objekten befüllt werden kann.

`
create-form-window
    [[-text] <String>]
    [[-bgcolor] <String>]
    [[-startposition] <String>]
    [[-icon] <String>]
    [[-height] <String>]
    [[-width] <String>]
`

**Beispiel 1**

`
$form = create-form-window -text "Hallo Welt" -startposition "centerscreen"
[void] $form.ShowDialog()
`

**Bemerkungen**

Die gesammte Funktion muss in eine Variable gespeichert werden, damit sie später mit dem `ShowDialog()` angezeigt werden kann. Objekte müssen zwischen der ersten und zweiten Zeile erstellt werden. Siehe Funktion `create-form-object`.

---

### Funktion: create-form-object
Erstellt eine Variable welche zum Beispiel bei Remotbefehlen verwendet werden kann.

`
create-form-object
    [[-form] <var>]
    [[-type] <String>]
    [[-text] <String>]
    [[-value] <int>]
    [[-height] <int>]
    [[-width] <int>]
    [[-autosize] <bool>]
    [[-enabled] <bool>]
    [[-bgcolor] <String>]
    [[-font] <String>]
    [[-imagepath] <String>]
    [[-xpos] <int>]
    [[-ypos] <int>]
    [[-click] <String>]
`

**Beispiel 1**

`
create-form-object -form $form -type 'button' -height 30 -width 120 -click $event
$event = { Write-Host "Button used" }
`

**Bemerkungen**

Wichtig ist, dass die `$form` immer mitgegeben wird, damit das Objekt gezeichnet werden kann. Mithilfe des Parameters `-type` wird ein Button erstellt. Die Variable `$event` enthält die Anweisung, falls der Button gedrückt wurde.

**Beispiel 2**

`create-form-object -form $form -type 'label' -height 30 -width 120 -text "Hallo Welt"`

**Bemerkungen**

In dieser Funktion wird ein Label erstellt, welches den Text "Hallo Welt" ausgibt.


