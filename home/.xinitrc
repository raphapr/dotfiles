#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xset r rate 200 30
xrdb -merge ~/.Xresources

export XLOGFILE=~/xlog/i3log-$(date +'%d-%m-%Y %kh%Mm%Ss') 
exec i3 -V >> ~/xlog/i3log-$(date +'%d-%m-%Y %kh%Mm%Ss') 2>&1
