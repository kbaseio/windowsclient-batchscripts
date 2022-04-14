@echo off
 
echo
echo *************************************************************************
echo * Stopping services
echo *************************************************************************
 
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
 
echo
echo *************************************************************************
echo * Clearing tmp files
echo *************************************************************************
 
del "%tmp%" /s /q 
del "%temp%" /s /q 
del C:\*.tmp /s /q
del C:\users\*\AppData\Local\Temp\*
del C:\Windows\Temp\*
 
echo
echo *************************************************************************
echo * Clearing failed Windows Update folders
echo *************************************************************************

echo SKIPPING THIS STEP AS IT TAKES TOO LONG. UNCOMMENT TO PROCEED.
rem Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
 
echo
echo *************************************************************************
echo * Clearing Client ID from Registry
echo *************************************************************************

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v AccountDomainSid /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v PingID /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /f

echo
echo *************************************************************************
echo * Renaming C:\Windows\SoftwareDistribution (with current date and time)
echo *************************************************************************
 
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old-%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%
 
echo
echo *************************************************************************
echo * Renaming  C:\Windows\System32\catroot2 (with current date and time)
echo *************************************************************************
 
ren C:\Windows\System32\catroot2 Catroot2.old-%date:~10,4%%date:~7,2%%date:~4,2%_%time:~0,2%%time:~3,2%
 
echo
echo *************************************************************************
echo * Resetting ownership and deleting $Windows.~BT + $Windows.~WS folders
echo *************************************************************************
 
takeown /F C:\$Windows.~BT\* /R /A 
icacls C:\$Windows.~BT\*.* /T /grant administrators:F 
rmdir /S /Q C:\$Windows.~BT\
 
takeown /F C:\$Windows.~WS\* /R /A 
icacls C:\$Windows.~WS\*.* /T /grant administrators:F 
rmdir /S /Q C:\$Windows.~WS\
 
echo
echo *************************************************************************
echo * Restarting Services
echo *************************************************************************
 
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
 
echo
echo *************************************************************************
echo * Done. Wait a moment for the computer to report.
echo *************************************************************************