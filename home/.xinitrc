#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xset r rate 200 30

exec startkde -V >> ~/klogs/kdelog-$(date +'%d-%m-%Y%kh%Mm%Ss') 2>&1

#exec i3
