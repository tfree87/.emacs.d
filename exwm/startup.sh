#!/bin/sh
# Pulseaudio

# Start pulseaudio


pulseaudio --start &



# Launch the pulseaudio system tray app


pasystray &

# Emacs EXWM

# Launch Emacs in maximized mode and debug the init file


exec dbus-launch --exit-with-session emacs -mm --debug-init
