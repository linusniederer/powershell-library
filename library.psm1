#
# PowerShell library
# This library contains some PowerShell functions which are needed in everyday programming.
# 
# Author: @https://github.com/linusniederer
# Repository: @https://github.com/linusniederer/powershell-library
# Documentation: @https://github.com/linusniederer/powershell-library/blob/master/documentation.md
#

#
# Functions to get special information about virtual machines running on Windows Hyper-v
# Example: @https://github.com/linusniederer/powershell-library/blob/master/examples/get-vm-ipaddress.ps1
#
function get-vm-ipaddress ( $vmname, $type ) {

    # 
    # Check if ipv4 is requested
    # Loads the ipv4 address from the virtual network adapter object
    #
    if ( $type -eq "ipv4" -or $type -eq 4 ) {
        $network = ( Get-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    } 

    #
    #
    #
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

function connect-database ( $dbhost, $database, $user, $pass, $port ) { 

    # Objekt aus .Net Connector importieren
    [void][system.reflection.Assembly]::LoadWithPartialName("MySql.Data") 

    # Standardoptionen
    if ( $dbhost -eq $NULL ) { $dbhost = "localhost" }
    if ( $user -eq $NULL ) { $user = "root" }
    if ( $port -eq $NULL ) { $port = 3306 }

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
        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection( $information ) 
        $connection.Open() 

        # Verbindungsvariable zurückgben
        return $connection 
    
    } else {
        
        # Wenn nicht alle Informationen ausgefüllt sind
        return "ERROR: Fehlende Verbindungsinformationen"

    }
    
    # QUELLE: https://vwiki.co.uk/MySQL_and_PowerShell

}

function read-database ( $connection, $sql ) {

    # Daten überprüfen
    if ( $connection -ne $NULL -AND $sql -ne $NULL) {

        # Neues Objekt erzeugen
        $command = New-Object MySql.Data.MySqlClient.MySqlCommand($sql, $connection) 

        # Adapter erzugen
        $dataadapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($command)  

        # Daten zusammenstellen
        $dataset = New-Object System.Data.DataSet
        $dataadapter.Fill($dataset, "data")   

        # Objekt Schliessen
        $command.Dispose()

        # Rückgabe der Daten
        return $dataset.Tables["data"]  

    } else {
        
        # Wenn nicht alle Informationen ausgefüllt sind
        return "ERROR: Fehlende Informationen für das Ausführen von Queries"
    
    }
    
    # QUELLE: https://vwiki.co.uk/MySQL_and_PowerShell

}

function write-database ( $connection, $sql ) {

    # Daten überprüfen
    if ( $connection -ne $NULL -AND $sql -ne $NULL) {

        # Neues Objekt erzeugen
        $command = $connection.CreateCommand()
        
        # Zuweisen des SQL Queries
        $command.CommandText = $sql                    

        # Kommando ausführen
        $insert = $command.ExecuteNonQuery()       
        $command.Dispose() 
                              
        # Überprüfen ob es geklappt hat oder nicht
        if ( $insert ) { 

            # Rückgabe des Befehls
            return $insert 

        } else {
            
            # Rückgabe des Fehlers
            return $false 
        } 
    
    } else {
        
        # Wenn nicht alle Informationen ausgefüllt sind
        return "ERROR: Fehlende Informationen für das Ausführen von Queries"

    }

    # QUELLE: https://vwiki.co.uk/MySQL_and_PowerShell

}