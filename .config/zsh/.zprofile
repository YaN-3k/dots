# start X-server
[ $(tty) = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
