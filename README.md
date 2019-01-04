# PowerShell Library for daily use
Dieses Projekt beinhaltet eine Bibliothek für die Skriptssprache Powershell. Entscheidend ist die Datei «library.ps1».


### Einbinden der Bibliothek
Sobald die Datei «library.ps1» heruntergeladen worden ist, muss sie der Ordnerstruktur des Projektes hinzugefügt werden. 

Mit folgendem Code kann die Library dann eingebunden werden:

```ps1
.[Pfad]\library.ps1
```

Damit alle Funktionen richtig verwendet werden können ist es wichtig, dass folgende Variabeln am Anfang definiert werden. Deshlab lohnt es sich, folgenden Skriptteil direkt hineinzukopieren.

```ps1
$scp      = $PSScriptRoot
$tsp      = Get-Date -UFormat "%Y-%m-%d"
$fin      = $MyInvocation.ScriptName

$url      = "https://github.com/linusniederer/powershell-library/blob/master/library.ps1"
$library  = "$scp\library.ps1"

."$library"
```

Nun können die Funktionen im Projekt verwendet werden. Eine Übersicht aller Funktionen findet man im Ordner \docs\functions.md