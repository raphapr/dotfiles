#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

xset r rate 200 30
xrdb -merge ~/.Xresources

#exec startkde -V >> ~/xlog/kdelog-$(date +'%d-%m-%Y %kh%Mm%Ss') 2>&1
#exec i3 -V >> ~/xlog/i3log-$(date +'%d-%m-%Y %kh%Mm%Ss') 2>&1

#xfce4+i3
date=$(date +'%d-%m-%Y %kh%Mm%Ss')
exec startxfce4 -V >> ~/xlog/xfce4log-$date 2>&1
