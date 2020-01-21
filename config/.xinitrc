#!/bin/bash
setbg &     # set the background with the `setbg` script
remaps &    # run the remaps script, switching caps/esc and more; check it for more info
setxkbmap pl &		 # set polish keyboard
xrdb ~/.Xresources & # load ~/.Xresources
xsetroot -cursor_name left_ptr & # change the cursor shape from "x" to normal
unclutter & # Remove mouse when idle
blueman-applet &
dunst &
picom &
mpd &
~/.config/polybar/launch.sh &
sxhkd &
exec bspwm
