Class LogItem {

    [String] $value
    [DateTime] $timestamp
    [String] $type = "debug"
    [String] $color = "white"

    <#
     # Constructor of LogItem Class
     # @param [String] value Log message
     #>
    LogItem ($value) {
        $this.value = $value
        $this.timestamp = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
        $this.isSuccess()
        $this.isWarning()
        $this.isError()
    }

    <#
     # ToString Method to return Log message
     # @return [String] Log message to write out
     #>
    [String] toString () {
        return "$($this.timestamp) > $($this.value)"
    }

    <#
     # Get color uf current log item
     # @return [String] Color of current log item
     #>
    [String] getColor() {
        return $this.color
    }

    <#
     # Method to determind if item is a success
     # @return [boolean] return true if item is a success
     #>
     hidden [boolean] isSuccess() {
        $pattern = @("Success", "Done", "Okay", "Correct", "no error", "no warning", "Erfolgreich")
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            $this.color = "green"
            $this.type = "success"
            return $true
        }
        return $false
    }

    <#
     # Method to determind if item is a warning
     # @return [boolean] return true if item is a warning
     #>
    hidden [boolean] isWarning() {
        $pattern = @("Warnung", "Warning", "WARNING", "Warn", "Warnings")
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            $this.color = "yellow"
            $this.type = "warning"
            return $true
        }
        return $false
    }

    <#
     # Method to determind if item is an error
     # @return [boolean] return true if item is error
     #>
    hidden [boolean] isError() {
        $pattern = @("Fehler", "Error", "ERROR", "Fail", "Failure")
        if( Select-String -InputObject $this.value -Pattern $pattern ) {
            $this.color = "red"
            $this.type = "error"
            return $true
        } 
        return $false
    }
}