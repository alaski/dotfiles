#!/bin/bash

xrandr | grep VGA1 | grep " connected "
if [ $? -eq 0 ]; then
    # External monitor is connected
    xrandr --output LVDS1 --mode 1280x800 --output VGA1 --mode 1440x900 --left-of LVDS1
    if [ $? -ne 0 ]; then
        # Something went wrong.  Autoconfigure internal monitor and disable external one
        xrandr --output LVDS1 --mode auto --output VGA1 --off
    fi
else
    # External monitor is not connected
    xrandr --output LVDS1 --mode 1280x800 --output VGA1 --off
fi
