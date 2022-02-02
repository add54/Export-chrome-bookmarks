@ECHO off
title backup bookmarks on Winodows 10

REM  Recommended to run during user logoff in GPO (User Configuration\Policies\Windows Settings\scripts)

REM Path for the user's network file share
SET userprivatedrivepath=%HOMESHARE%\

REM Path for bookmark backup folder in user's network file share
SET userbookmarkspath=%userprivatedrivepath%\bookmark_backups

REM bookmark locations on user's computer
SET bookmark_chrome=%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default

REM bookmark backup path for the computer the user logged on to
SET userbookmarkspathcomputer=%userbookmarkspath%\%computername%

REM create folder to backup a computer's bookmarks to
IF NOT EXIST "%userbookmarkspath%" (
	mkdir "%userbookmarkspath%"
)

REM backup bookmarks
ROBOCOPY "%bookmark_chrome%" "%userbookmarkspath%" Bookmarks /COPY:DAT /DCOPY:T /R:1 /W:30 /NP

REM save a script that opens the users chrome folder
echo explorer %USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\ > %userbookmarkspath%\openChromeFolder.bat