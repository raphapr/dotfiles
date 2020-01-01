#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

sleep 1

setxkbmap -option keypad:pointerkeys
xmodmap ~/.Xmodmap

xset r rate 240 50

[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

exec dbus-launch --sh-syntax --exit-with-session i3 --shmlog-size=26214400
