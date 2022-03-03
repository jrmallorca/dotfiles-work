PowerShell -Command "Set-ExecutionPolicy Unrestricted CurrentUser" >> "%TEMP%\StartupLog.txt" 2>&1
PowerShell %USERPROFILE%\.config\scripts\powershell\start-komorebi.ps1 >> "%TEMP%\StartupLog.txt" 2>&1
PowerShell -Command “Set-ExecutionPolicy Restricted” >> "%TEMP%\StartupLog.txt" 2>&1