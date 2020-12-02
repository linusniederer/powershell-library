# Module: Logging
The Logging class can be used to log any operations in a PowerShell application. There is the possibility to customize the type of logging. For example you can choose whether the log is displayed in the console or saved as a file.

## Usage
```powershell
Import-Module Logging

Write-Log "this is a Warning!"
Write-Log "this is an Error" 
Write-Log "everything is Normal"
Write-Log "Task was successfull!"
```

The code shown above produces the following output to the console. The words Warning, Error, Normal and Successful are used to change the output color.

![Class Logging console output](https://github.com/linusniederer/powershell-library/blob/master/src/main/moduldoc/images/Logging-consoleOutput-01.png)
