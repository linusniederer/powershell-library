Class LogItem {
    [String] $value
    [DateTime] $timestamp
    [String] $type = "debug"

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
            $this.type = "error"
            return $true
        } else {
            return $false
        }
    }
    
    hidden [boolean] isWarning() {
        $pattern = @('Warnung', 'Warning', 'WARNING', 'Warn', 'Warnings')
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            $this.type = "warning"
            return $true
        } else {
            return $false
        }
    }
}