# Modul importieren
Import-Module .\library.psm1

# Neue Form erstellen
$gui = create-form-window -text "Github Form" -bgcolor "#0f0f0f" -icon "./icon.png" -height 800 -width 1200

# Label erstellen welches nicht mehr geändert werden kann
create-form-object -type "label" -form $gui -xpos 20 -ypos 20 -text "Mein erstes Label"

# Aktion des Buttons
$action = {
    # wird bei Button ausgeführt
}

# Dynamischer Button erstellen
$register = create-form-object -type "button" -xpos 100 -ypos 20 -width 200 -text "Registrieren" -click $action

# Button ausgeben
$gui.controls.AddRange(@( $register ))

# Ausgabe der Form
[void] $gui.ShowDialog()