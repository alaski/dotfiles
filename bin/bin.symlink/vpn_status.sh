#!/bin/bash

PID=`pidof xmobar`

while [[ $PID -eq $(pidof xmobar) ]]; do
    if [[ -n $(pidof vpnc) ]]; then
        echo VPN
    else
        echo ""
    fi
    sleep 10
done
