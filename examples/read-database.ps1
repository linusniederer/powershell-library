# Modul importieren
Import-Module .\library.psm1

# Verbindung zur Datenbank aufbauen
$db_link = connect-database -dbhost "localhost" -database "test" -user "root" -pass ""

# SQL Befehl definieren
$statement = "SELECT * FROM users WHERE id LIKE 2"

# Daten in Form eines Objektes ausgeben
read-database -connection $db_link -sql $statement