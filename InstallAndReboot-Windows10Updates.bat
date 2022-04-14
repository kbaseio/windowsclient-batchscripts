REM Download and Fully Install Windows Updates
REM by www.URTech.ca Ian Matthews
REM Last Updated Nov 19 2018

REM These two commands do not need a path
usoclient ScanInstallWait
usoclient StartInstall

REM Wait 40 mins to allow all the installs to complete
timeout /T 2400

REM download from https://dennisbabkin.com/utilities/#ShutdownWithUpdates
REM this command will need a local path to the file unless it is run from the same folder that contains it
ShutdownWithUpdates.exe /r /f