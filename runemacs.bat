rem runemacs.bat - A script to launch Emacs from a flash drive
rem Author : Thomas Freeman
rem Time-stamp: <2022-03-28 18:48:26 Thomas>


rem Set the Emacs home directory to the drive label of the flash drive.
set HOME=%~dp0

rem Set an evironment variable to tell Emacs that it is running portably
set EMACS_PORTABLE="Y"

rem Find the Emacs executable and execute it.
"%~dp0/emacs/bin/runemacs.exe" %
