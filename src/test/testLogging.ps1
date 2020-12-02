$env:PSModulePath += ";C:\Users\linusniederer.OPACC\myCloud\Projekte\Aktuell\GitHub.com\powershell-library\src\main\modules"
Import-Module Logging


Write-Log "There is a Warning in the Matrix"
Write-Log "There is an Error in the Matrix!" 
Write-Log "There is everything okay in the Matrix"
Write-Log "Matrix is successful!"


Remove-Module Logging