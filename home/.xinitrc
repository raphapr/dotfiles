#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xset r rate 200 30
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources

#exec i3 --shmlog-size=26214400
exec dbus-launch --sh-syntax --exit-with-session i3 --shmlog-size=26214400
