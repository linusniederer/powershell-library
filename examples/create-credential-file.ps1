# Modul importieren
Import-Module .\library.psm1

# Passwort in eine verschlüsselte Datei auslagern
create-credential-file -password "1234" -filepath "C:\temp\pw.txt"

# Sicherheitsdatei verwenden
$cred = create-credential -user "administrator" -domain "github.com" -securefile "C:\temp\pw.txt"
