#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#

#exec startkde -V >> ~/xlog/kdelog-$(date +'%d-%m-%Y %kh%Mm%Ss') 2>&1
exec i3 -V >> ~/xlog/i3log-$(date +'%d-%m-%Y %kh%Mm%Ss') 2>&1
