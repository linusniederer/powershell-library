#
# Powershell Skript by LINUS
# 
# 26.10.2018
#
# Dies ist eine Library für bestimmte Powershell Funktionen welche
# in weitere Skritps eingebunden werden kann.
#
# Die Library darf verwendet und abgeändert werden.
#
#

#
# --------------------------------------------------------
# Abschnitt: HYPER-V MANAGEMENT
# --------------------------------------------------------
#

function get-vm-ipaddress ( $vmname, $type ) {

    # IPv4 Adresse laden
    if ( $type -eq "ipv4" -or $type -eq 4 ) {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    } 

    # IPv6 Adresse laden
    if ( $type -eq "ipv6" -or $type -eq 6 ) {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[1]
    } 

    # Wenn $type = $NULL dann IPv4
    else {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    }

    return $ipaddress;
}

#
# --------------------------------------------------------
# Abschnitt: AUTHENTIFIZIERUNG
# --------------------------------------------------------
#

function create-credential ( $user, $domain, $password, $securefile ) {

    # Passwort befindet sich in Sicherheitsdatei
    if ( $securefile -ne $NULL ) { 
        
        $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$domain\$user", (Get-Content $securefile | ConvertTo-SecureString) 
    }

    # Passwort in Klartext verwendent
    if ( $password -ne $NULL ) { 
    
        $securepw = ConvertTo-SecureString $password -AsPlainText -Force
        $securepw = ConvertFrom-SecureString $securepw

        $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$domain\$user", ($securepw | ConvertTo-SecureString)
    }

    return $credential
}

function create-credential-file ( $password, $filepath )  {

    $securepw = ConvertTo-SecureString $password -AsPlainText -Force
    $securepw | ConvertFrom-SecureString | Out-File $filepath
}

#
# --------------------------------------------------------
# Abschnitt: BENUTZEROBERFLÄCHE
# --------------------------------------------------------
#

function create-form-window ($text, $bgcolor, $startposition, $icon, $maximize, $height, $width ) {
    
    # Module installieren
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    # Standardoptionen wenn $param = NULL  
    if ( $bgcolor -eq $NULL )        { $bgcolor = "white" }
    if ( $startposition -eq $NULL )  { $startposition = "centerscreen" }
    if ( $maximize -eq $NULL )       { $maximize = $false }
    if ( $height -eq $NULL )         { $height = 400 }
    if ( $width -eq $NULL )          { $width = 800 }

    # Form Objekt erzeugen
    $form = New-Object System.Windows.Forms.Form

    # Optionen Objekt zuweisen
    $form.text              = $text
    $form.backcolor         = $bgcolor
    $form.startposition     = $startposition
    $form.icon              = $icon
    $form.MaximizeBox       = $maximize
    $form.minimumSize       = New-Object System.Drawing.Size( $width, $height )
    $form.MaximumSize       = New-Object System.Drawing.Size( $width, $height )
    $form.size              = New-Object System.Drawing.Size( $width, $height )

    return $form;

}

function create-form-object ( $form, $type, $text, $value, $height, $width, $autosize, $enabled, $color, $bgcolor, $font, $imagepath, $xpos, $ypos, $click, $dynamic ) {
    
    # Standardoptionen Form
    if ($form -eq $NULL ) { $form = create-form-window -height 400 -width 800 -bgcolor "white" -startposition "centerscreen" -text "Generated!!!" }

    # Standardoptionen $param = NULL  
    if ( $type -eq $NULL )     { $type = "label" }
    if ( $autosize -eq $NULL ) { $autosize = $true }
    if ( $color -eq $NULL )    { $color = "black" }
    if ( $bgcolor -eq $NULL )  { $bgcolor = "white" }
    if ( $enabled -eq $NULL )  { $enabled = $true }
    if ( $dynamic -eq $NULL )  { $dynamic = $false }

    # Type des Objektes bestimmen
    if ( $type -eq "textbox" )  { $object = New-Object System.Windows.Forms.TextBox }
    if ( $type -eq "label" )    { $object = New-Object System.Windows.Forms.Label }
    if ( $type -eq "button" )   { $object = New-Object System.Windows.Forms.Button }
    if ( $type -eq "checkbox" ) { $object = New-Object System.Windows.Forms.Checkbox }

    # Spzial Typen
    if ( $type -eq "picturebox" )  { 
        $object = New-Object System.Windows.Forms.PictureBox 
        $object.ImageLocation = $imagepath
    }

    if ( $type -eq "progressbar" ) { 
        $object = New-Object System.Windows.Forms.ProgressBar 
        $object.value  = $value
    }

    # Optionen dem Objekt zuweisen
    $object.text        = $text
    $object.height      = $height
    $object.width       = $width
    $object.autosize    = $autosize
    $object.enabled     = $enabled
    $object.ForeColor   = $color
    $object.backcolor   = $bgcolor
    $object.font        = $font
    $object.location    = New-Object System.Drawing.Point( $xpos, $ypos )

    # Events bestimmen
    $object.add_click( $click )

    # Dynamische Objekte erzeugen
    if ( $dynamic -eq $false ) {
        $form.Controls.Add( $object )
        return $form
    } 
    
    # kein Dynamisches Objekt
    if ( $dynamic -eq $true ) {
        return $object
    }
    

}

function create-file-dialog ( $path, $filetype ) {
    
    # Standardoptionen $param = NULL  
    if ( $path -eq $NULL )     { $path = "C:\" }
    if ( $filetype -eq $NULL ) { $filetype = 'Alle Dateien (*.*)|*.*"."'}

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $path
    $OpenFileDialog.filter = $filetype
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename

}

#
# --------------------------------------------------------
# Abschnitt: LOGGEN
# --------------------------------------------------------
#

function write-log () {
    
    # log initialisieren
    $text = $args[0]
    $logpath = $Global:scp 
    $logtime = $Global:tsp
    $filename = "runtimelog"
    $logfile = $logpath + "\log\" + $filename + "_" + $logtime + ".log"
    $color = "white"
    $time = Get-Date -DisplayHint time

    # Fehler gefunden
    if ( $text -like "*ERROR*" -OR $text -like "*FEHLER*" ) { $color = "red" }
    
    # Wahrnung gefunden
    if ( $text -like "*WARNING*" -OR $text -like "*WARNUNG*" ) { $color = "yellow" }

    if ( Get-Item -Path $logfile -ErrorAction SilentlyContinue ) {
        
        # log existiert bereits
        "$time > $text" | Add-Content $logfile

    } else {

        # neues Log erstellen
        New-Item -Path $logfile -Force
        "$time > $text" | Add-Content $logfile
    }

    # in Terminal ausgeben
    Write-Host "$time > $text" -ForegroundColor $color
       
}

#
# --------------------------------------------------------
# Abschnitt: DATENBANKEN
# --------------------------------------------------------
#

function connect-database ( $dbhost, $database, $user, $pass, $port) { 

    # Objekt aus .Net Connector importieren
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 

    # Standardoptionen
    $dbhost = "localhost"
    $user = "root"
    $port = 3306

    # Überprüfen ob alle Angaben vorhanden
    if ( $database -ne $NULL -AND $pass -ne $NULL ) {

        # Verbindungsinformationen
        $information = "
            server=$dbhost;
            port=$port;
            uid=$user;
            pwd=$pass;
            database=$database;
            Pooling=FALSE
        " 
        
        # Verbindung herstellen
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection($information) 
        $connection.Open() 

        # Verbindungsvariable zurückgben
        return $connection 
    
    } else {
        
        # Wenn nicht alle Informationen ausgefüllt sind
        return "ERROR: Fehlende Verbindungsinformationen"

    }
    
    # QUELLE: https://vwiki.co.uk/MySQL_and_PowerShell

}

function close-database () {

}