#!/bin/sh
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
	bars=$(awk -F '[|/|]|]' '/\[bar/ { printf $2"\n" }' ~/.config/polybar/config)
	for i in $bars; do
		WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') WIRED=$(ls /sys/class/net/ | grep ^en | awk 'NR==1{print $1}') MONITOR=$m polybar --reload "$i" &
	done
done
