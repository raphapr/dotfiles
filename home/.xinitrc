#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xset r rate 200 30
xrdb -merge ~/.Xresources

exec i3 --shmlog-size=26214400
