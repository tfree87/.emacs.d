#!/bin/sh
# Numlock

# Turn on numlock for number pads


numlockx on

# Tap To Click

# Enable tap to click using the laptop touchpad


xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1

# Pulseaudio

# Start pulseaudio


pulseaudio --start &



# Launch the pulseaudio system tray app


pasystray &

# Emacs EXWM

# Launch Emacs in maximized mode and debug the init file


exec dbus-launch --exit-with-session emacs -mm --debug-init
