#!/bin/bash - 
#===============================================================================
#
#          FILE: .battery.sh
# 
#         USAGE: ./.battery.sh 
# 
#   DESCRIPTION: imprime coração preenchido + porcentagem da bateria se estiver carregado, se não, imprime coração vazio + porcentagem no tmux status bar
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Raphael P. Ribeiro 
#  ORGANIZATION: 
#       CREATED: 17-04-2014 17:39:36 BRT
#      REVISION:  ---
#===============================================================================

HEART_FULL="♥"
HEART_EMPTY="♡"
PORCENTAGEM=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | cut -d ":" -f 2 | tr -d ' ')
ESTADO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep state | cut -d ":" -f 2 | tr -d ' ')


if [[ $ESTADO == "fully-charged" ]]; then 
    echo $HEART_FULL $PORCENTAGEM
else
    echo $HEART_EMPTY $PORCENTAGEM
fi
