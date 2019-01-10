# Modul importieren
Import-Module .\library.psm1

# Passwort in Klartext verwenden
$cred = create-credential -user "administrator" -domain "github.com" -password "123"

# Verwenden des Credential
New-Item -Path "C:\Test" -Credential $cred