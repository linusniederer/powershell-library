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

    # if Type empty -> IPv4
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

function create-form-window ($bgcolor, $startposition, $height, $width, $text ) {
    
    # init form moduls
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

    # set form options
    $form = New-Object System.Windows.Forms.Form
    $form.BackColor = $bgcolor
    $form.StartPosition = $startposition
    $form.Size = New-Object System.Drawing.Size( $width, $height )
    $form.Text = $text

    return $form;

}

function create-form-object ( $form, $type, $text, $height, $width, $autosize, $enabled, $bgcolor, $font, $xpos, $ypos ) {
    
    # check for errors
    if ($form -eq $NULL ) { $form = create-form-window -height 400 -width 800 -bgcolor "white" -startposition "centerscreen" -text "Generated!!!" }

    # standard options if $param = NULL  
    if ( $type -eq $NULL ) { $type = "label" }
    if ( $autosize -eq $NULL ) { $autosize = $true }
    if ( $bgcolor -eq $NULL ) { $bgcolor = "white" }
    if ( $enabled -eq $NULL ) { $enabled = $true }

    # get type of object
    if ( $type -eq "textbox" ) { $object = New-Object System.Windows.Forms.TextBox }
    if ( $type -eq "label" ) { $object = New-Object System.Windows.Forms.Label }

    # set object options
    $object.text                    = $text
    $object.height                  = $height
    $object.width                   = $width
    $object.autosize                = $autosize
    $object.enabled                 = $enabled
    $object.backcolor               = $bgcolor
    $object.font                    = $font
    $object.location                = New-Object System.Drawing.Point($xpos, $ypos)

    # add to form
    $form.Controls.Add($object)
    return $form

}