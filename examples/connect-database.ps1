# Modul importieren
Import-Module .\library.psm1

# Verbindung zur Datenbank aufbauen
$db_link = connect-database -dbhost "localhost" -database "test" -user "root" -pass ""