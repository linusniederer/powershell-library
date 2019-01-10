# PowerShell Library for daily use
Dieses Projekt beinhaltet eine Bibliothek für die Skriptssprache Powershell. Entscheidend ist die Datei «library.ps1».


### Einbinden der Bibliothek
Sobald die Datei «library.psm1 heruntergeladen worden ist, kann sie auf dem System eingebunden werden.

Mit folgendem Code kann die Library dann eingebunden werden:

```ps1
Import-Module [Pfad]\library.psm1
```

Damit alle Funktionen richtig verwendet werden können ist es wichtig, dass folgende Variabeln am Anfang definiert werden. Deshlab lohnt es sich, folgenden Skriptteil direkt hineinzukopieren.

```ps1
$scp      = $PSScriptRoot
$tsp      = Get-Date -UFormat "%Y-%m-%d"
$fin      = $MyInvocation.ScriptName

$url      = "https://github.com/linusniederer/powershell-library/blob/master/library.psm1"
```

Nun können die Funktionen im Projekt verwendet werden. Eine Übersicht aller Funktionen findet man hier:
https://github.com/linusniederer/powershell-library/blob/master/functions.md
