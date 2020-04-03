#!/bin/sh
setbg &        # set the background with the `setbg` script
remaps &       # run the remaps script, switching caps/esc and more; check it for more info
setxkbmap pl & # set polish keyboard
xrdb ~/.config/xrdb/Xdefaults    # load ~/.Xresources
xsetroot -cursor_name left_ptr & # change the cursor shape from "x" to normal
unclutter --timeout 3 -jitter 50 --ignore-scrolling & # Remove mouse when idle
dunst &
picom &
mpd &
sxhkd &
~/.config/polybar/launch.sh ice &
exec bspwm
