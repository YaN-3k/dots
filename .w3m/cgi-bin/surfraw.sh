#!/bin/sh
prefix=$(sr -elvi | tail -n +2 | fzf | cut -f1)
[ "$prefix" ] || exit
printf "Search using %s: " "$prefix"
read -r input
printf "%s" "$(sr -p "${prefix}" $input)" >/tmp/search
