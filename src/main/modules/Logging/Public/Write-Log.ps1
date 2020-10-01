function Write-Log ($Value) {

    $timestamp = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
    $logItem = [LogItem]::new($Value, $timestamp)

    Write-Host $logItem.ToString() -ForegroundColor "Blue"
}