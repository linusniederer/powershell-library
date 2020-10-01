$env:PSModulePath += ";C:\Users\linusniederer.OPACC\myCloud\Projekte\Aktuell\GitHub.com\powershell-library\src\main\modules"
Import-Module Logging


Write-Log "Warning in Matrix!"
Write-Log "Error in Matrix!" 
Write-Log "Matrix is Normal!"
Write-Log "Matrix is successful!"


Remove-Module Logging