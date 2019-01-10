# Modul importieren
Import-Module .\library.psm1

# Verbindung zur Datenbank aufbauen
$db_link = connect-database -dbhost "localhost" -database "test" -user "root" -pass ""

# SQL Befehl definieren
$statement = "INSERT INTO users (name, password, email) VALUES ('Max', 'Mustermann', 'max@')"

# Daten in Datenbank schreiben, liefert «1» zurück wenn es geklappt hat
write-database -connection $db_link -sql $statement