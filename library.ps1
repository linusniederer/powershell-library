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

    # get IPv4 Address
    if ( $type -eq "ipv4" -or $type -eq 4 ) {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    } 

    # get IPv6 Address
    if ( $type -eq "ipv6" -or $type -eq 6 ) {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[1]
    } 

    # if type empty -> IPv4
    else {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    }

    return $ipaddress;
}

#
# --------------------------------------------------------
# Abschnitt: AUTHENTICATION
# --------------------------------------------------------
#

function create-credential ( $user, $domain, $password, $securefile ) {

    # if there is a securefile to use
    if ( $securefile -ne $NULL ) { 
        
        $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "$domain\$user", (Get-Content $securefile | ConvertTo-SecureString) 
    }

    # if ithere ist a clear password to use
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
# Abschnitt: USER INTERFACE
# --------------------------------------------------------
#

function create-form-window ($text, $bgcolor, $startposition, $icon, $maximize, $height, $width ) {
    
    # init form moduls
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    # standard options if $param = NULL  
    if ( $bgcolor -eq $NULL )        { $bgcolor = "white" }
    if ( $startposition -eq $NULL )  { $startposition = "centerscreen" }
    if ( $maximize -eq $NULL )       { $maximize = $false }
    if ( $height -eq $NULL )         { $height = 400 }
    if ( $width -eq $NULL )          { $width = 800 }

    # create form object
    $form = New-Object System.Windows.Forms.Form

    # set form options
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
    
    # check for errors
    if ($form -eq $NULL ) { $form = create-form-window -height 400 -width 800 -bgcolor "white" -startposition "centerscreen" -text "Generated!!!" }

    # standard options if $param = NULL  
    if ( $type -eq $NULL )     { $type = "label" }
    if ( $autosize -eq $NULL ) { $autosize = $true }
    if ( $color -eq $NULL )    { $color = "black" }
    if ( $bgcolor -eq $NULL )  { $bgcolor = "white" }
    if ( $enabled -eq $NULL )  { $enabled = $true }
    if ( $dynamic -eq $NULL )  { $dynamic = $false }

    # get type of object
    if ( $type -eq "textbox" )  { $object = New-Object System.Windows.Forms.TextBox }
    if ( $type -eq "label" )    { $object = New-Object System.Windows.Forms.Label }
    if ( $type -eq "button" )   { $object = New-Object System.Windows.Forms.Button }
    if ( $type -eq "checkbox" ) { $object = New-Object System.Windows.Forms.Checkbox }

    # special type
    if ( $type -eq "picturebox" )  { 
        $object = New-Object System.Windows.Forms.PictureBox 
        $object.ImageLocation = $imagepath
    }

    if ( $type -eq "progressbar" ) { 
        $object = New-Object System.Windows.Forms.ProgressBar 
        $object.value  = $value
    }

    # set object options
    $object.text        = $text
    $object.height      = $height
    $object.width       = $width
    $object.autosize    = $autosize
    $object.enabled     = $enabled
    $object.ForeColor   = $color
    $object.backcolor   = $bgcolor
    $object.font        = $font
    $object.location    = New-Object System.Drawing.Point( $xpos, $ypos )

    # set object events
    $object.add_click( $click )

    # if dynamic = $false --> return Form
    if ( $dynamic -eq $false ) {
        $form.Controls.Add( $object )
        return $form
    } 
    
    # if dynamic = $false --> return Object
    if ( $dynamic -eq $true ) {
        return $object
    }
    

}

function create-file-dialog ( $path, $filetype ) {
    
    # standard options if $param = NULL  
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
# Abschnitt: REPORTING
# --------------------------------------------------------
#

function write-log () {
    
    #   $scp = $PSScriptRoot
    #   $tsp = Get-Date -UFormat "%Y-%m-%d"
    #   $fin = $MyInvocation.ScriptName

    # init log
    $text = $args[0]
    $logpath = $Global:scp 
    $logtime = $Global:tsp
    $filename = "runtimelog"
    $logfile = $logpath + "\log\" + $filename + "_" + $logtime + ".log"
    $color = "white"
    $time = Get-Date -DisplayHint time

    # ERROR found
    if ( $text -like "*ERROR*" -OR $text -like "*FEHLER*" ) { $color = "red" }
    
    # WARNING found
    if ( $text -like "*WARNING*" -OR $text -like "*WARNUNG*" ) { $color = "yellow" }

    if ( Get-Item -Path $logfile -ErrorAction SilentlyContinue ) {
        
        # log existing
        "$time > $text" | Add-Content $logfile

    } else {

        # create new log
        New-Item -Path $logfile -Force
        "$time > $text" | Add-Content $logfile
    }

    # screenoutput
    Write-Host $text -ForegroundColor $color
       
}

#
# --------------------------------------------------------
# Abschnitt: DATABASES
# --------------------------------------------------------
#

function connect-database () {

}

function close-database () {

}