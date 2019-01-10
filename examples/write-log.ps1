# Modul importieren
Import-Module .\library.psm1

# Variabeln welche zwingend definiert werden müssen
$scp      = $PSScriptRoot
$tsp      = Get-Date -UFormat "%Y-%m-%d"
$fin      = $MyInvocation.ScriptName

# Log erstellen
write-log "ERROR: der Vorgang konnte nicht ausgeführt werden!"