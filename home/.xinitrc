#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

setxkbmap -option keypad:pointerkeys

# remapping keys
sleep 5 && xmodmap ~/.Xmodmap

xset r rate 215 35

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

#exec i3 --shmlog-size=26214400
exec dbus-launch --sh-syntax --exit-with-session i3 --shmlog-size=26214400
