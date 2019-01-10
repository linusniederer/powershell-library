# Modul importieren
Import-Module .\library.psm1

# Neue Form erstellen
$form = create-form-window -text "Github Form" -bgcolor "#0f0f0f" -icon "./icon.png" -height 800 -width 1200

# CODE

# Ausgabe der Form
[void] $form.ShowDialog()