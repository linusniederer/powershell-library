# Modul importieren
Import-Module .\library.psm1

# Benutzer auffordern eine Datei auszuwählen
$file = create-file-dialog -path "C:\temp"