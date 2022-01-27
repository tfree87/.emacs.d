rem runemacs.bat - A script to launch Emacs from a flash drive
rem Author : Thomas Freeman
rem Time-stamp: <2022-01-27>


rem Set the Emacs home directory to the drive label of the flash drive.
set HOME=%~dp0

rem Find the Emacs executable and execute it.
"%~dp0/emacs/bin/runemacs.exe" %
