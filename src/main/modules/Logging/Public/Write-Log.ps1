function Write-Log ($Value) {
    $logItem = [LogItem]::new($Value)
    Write-Host $logItem.ToString() -ForegroundColor $logItem.getColor()
}