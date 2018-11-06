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
    if ( $type -eq "IPv4" -or $type -eq 4 ) {
        $network = ( GEt-VM -VMName $vmname | Get-VMNetworkAdapter).IpAddresses | Select-String -List 1;
        $ipaddress = $network[0]
    } 

    # get IPv6 Address
    if ( $type -eq "IPv6" -or $type -eq 6 ) {
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
