#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

setxkbmap -option keypad:pointerkeys

# remove caps lock function
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'

xset r rate 215 35
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

#exec i3 --shmlog-size=26214400
exec dbus-launch --sh-syntax --exit-with-session i3 --shmlog-size=26214400
