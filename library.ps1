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

function create-vm ( $vmname, $generation, $ram, $dynamicmemory, $switch, $vhdpath, $cpu, $integration, $startaction, $stopaction ) {
    
    # create new vm
    New-VM -Name $vmname -Generation $generation -MemoryStartupBytes $ram -SwitchName $switch -VHDPath $vhdpath
    
    # set vm options
    Set-VMProcessor -VmName $vmname -Count $cpu
    Set-VMMemory -VmName $vmname -DynamicMemoryEnabled $false
    Set-VM -VmName $vmname -AutomaticStopAction $stopaction
    Set-VM -VmName $vmname -AutomaticStartAction $startaction

    # integrationservices
    Enable-VMIntegrationService -Name “Gastdienstschnittstelle” -vmName "$name"
    Disable-VMIntegrationService -Name “Zeitsynchronisierung” -vmName "$name"
}

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
# Abschnitt: ERROR REPORTING
# --------------------------------------------------------
#