<#
 # 
 #
 #
 #>

Class Logging {
    [boolean] $writeFile = $false;
    [String] $logPath;    
}

Class LogItem {
    [String] $value
    [DateTime] $timestamp

    LogItem ($value, $timestamp) {
        $this.value = $value
        $this.timestamp = $timestamp
    }

    [String] toString () {
        return "$($this.timestamp) > $($this.value)"
    }

    hidden [boolean] isError() {
        $pattern = @('Fehler', 'Error', 'ERROR', 'Fail', 'Failure')
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            return $true
        } else {
            return $false
        }
    }
    
    hidden [boolean] isWarning() {
        $pattern = @('Warnung', 'Warning', 'WARNING', 'Warn', 'Warnings')
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            return $true
        } else {
            return $false
        }
    }
}


<#
 # 
 #
 #
 #>
function Write-Log ($Value) {

    $timestamp = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
    $logItem = [LogItem]::new($Value, $timestamp)

    Write-Host $logItem.ToString() -ForegroundColor "Blue"
}

# Export
Export-ModuleMember -Function "Write-Log"