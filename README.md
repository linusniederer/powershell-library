# PowerShell Library for daily use
Dieses Projekt beinhaltet eine Library für die Skriptssprache PowerShell.

### Einbinden der Bibliothek (automatisch)
Mit foglendem Code kann die Library direkt in jedes PowerShell Projekt eingebunden werden:

```ps1
$scp            = $PSScriptRoot
$tsp            = Get-Date -UFormat "%Y-%m-%d"
$fin            = $MyInvocation.ScriptName

$libraryname    = "ps-library-v1.0.ps1"
$librarypath    = "$scp/lib/$libraryname"
$libraryurl     = "https://raw.githubusercontent.com/linusniederer/powershell-library/master/library.psm1"
$libraryrequest = Invoke-WebRequest -uri $url

New-Item -path $librarypath -ItemType "file" -Force

."$librarypath"
```
Das Script lädt automatisch die aktuellste Version der Library herunter und speichert sie in den Unterordner /lib. Dieses Code Snippte sollte vor jedem Script eingefügt werden. So hat man den Vorteil, dass immer die aktuellste Version der Library verwendet wird.

### Einbinden der Bibliothek (manuell)
Sobald die Datei «library.psm1 heruntergeladen worden ist, kann sie auf dem System eingebunden werden.

Mit folgendem Code kann die Library dann eingebunden werden:

```ps1
Import-Module [Pfad]\library.psm1
```

Weitere Informationen zum Importieren von PowerShell Modulen findet man auf der Seite von Microsoft:
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/import-module?view=powershell-6

Damit alle Funktionen richtig verwendet werden können ist es wichtig, dass folgende Variabeln am Anfang definiert werden. Deshlab lohnt es sich, folgenden Skriptteil direkt hineinzukopieren.

```ps1
$scp      = $PSScriptRoot
$tsp      = Get-Date -UFormat "%Y-%m-%d"
$fin      = $MyInvocation.ScriptName

$url      = "https://github.com/linusniederer/powershell-library/blob/master/library.psm1"
```

### Weitere Informationen
Eine Übersicht aller Funktionen findet man hier: <br>
https://github.com/linusniederer/powershell-library/blob/master/functions.md

Für alle Funktionen, welche mit Datenbanken arbeiten, ist es notwendig, dass ein Connector installiert wurde. Den Connector für MySql findet man im Ordner `external`.
