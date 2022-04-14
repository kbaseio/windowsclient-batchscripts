@echo off

REM Source : https://www.ajtek.ca/wsus/client-machines-not-reporting-to-wsus-properly/

echo
echo *************************************************************************
echo * Stopping services
echo *************************************************************************
 
net stop bits
net stop wuauserv
 
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
echo * Renaming C:\Windows\SoftwareDistribution
echo *************************************************************************
 
rd /s /q "%SystemRoot%\SoftwareDistribution"
 
echo
echo *************************************************************************
echo * Restarting Services
echo *************************************************************************
 
net start bits
net start wuauserv


echo
echo *************************************************************************
echo * Reporting to WUSUS Server
echo *************************************************************************

wuauclt /resetauthorization /detectnow
PowerShell.exe (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()

echo
echo *************************************************************************
echo * Done. Wait a moment for the computer to report.
echo *************************************************************************