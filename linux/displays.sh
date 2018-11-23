#!/bin/bash

# displays home
# displays laptop
# displays class left
# displays class right
# displays --primary {laptop,external?}

# TODO: Add call to workspaces script

dual_head="--output LVDS1 --off --output HDMI1 --mode 1920x1080  --primary --output VGA1 --mode 1920x1080 --right-of HDMI1"
# dual_head="--output HDMI1 --mode 1920x1080  --primary --output VGA1 --auto --right-of HDMI1 --output LVDS1 --off"
docked="--output HDMI1 --mode 1920x1080 --primary --output LVDS1 --auto --right-of HDMI1 --output VGA1 --off"
laptop="--output LVDS1 --auto --primary --output HDMI1 --off --output VGA1 --off"
mirror="--output HDMI1 --mode 1920x1080 --output VGA1 --mode 1920x1080 --same-as HDMI1 --output LVDS1 --off"
hdmi_only="--output HDMI1 --mode 1920x1080 --primary --output VGA1 --off --output LVDS1 --off"

background=~/pictures/desktop-backgrounds/current

vga_connected=$(xrandr -q | grep "VGA1 connected")
hdmi_connected=$(xrandr -q | grep "HDMI1 connected")

args=$dual_head
workspaces="dual"

# if [ ! -n "$hdmi_connected" ]; then
    # args=$laptop_only
# fi

if [[ $1 == 'docked' ]]; then
    args=$docked
    workspaces=$1
fi

if [[ $1 == 'laptop' ]]; then
    args=$laptop
    workspaces=$1
fi

if [[ $1 == 'mirror' ]]; then
    args=$mirror
    workspaces='laptop'
fi

if [[ $1 == 'hdmi' ]]; then
    args=$hdmi_only
    workspaces='laptop'
fi

# if hdmi & vga connected
# dual_head

xrandr $args
workspaces $workspaces

if [ -e $background ]; then
    feh --bg-fill $background
fi
