#!/bin/sh
# Pulseaudio

# Start pulseaudio


pulseaudio --start &

# Dropbox

# Launch Dropbox daemon


dropbox start &

# Emacs EXWM

# Launch Emacs in maximized mode and debug he init file


exec dbus-launch --exit-with-session emacs -mm --debug-init
