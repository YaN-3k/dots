#!/bin/sh
setxkbmap pl &
unclutter &
picom &
remaps &
dwmbar &
theme dark
exec dwm
