#!/bin/sh
#
# See the LICENSE file for copyright and license details. 
#

xidfile="$HOME/.cache/tabbed-surf.xid"

runtabbed() {
	tabbed -cdn surf -r 2 surf -e '' "$@" >"$xidfile" \
		2>/dev/null &
}

if [ ! -r "$xidfile" ];
then
	runtabbed
else
	xid=$(cat "$xidfile")
	if xprop -id "$xid" >/dev/null 2>&1; then
		surf -e "$xid" "$@" >/dev/null 2>&1 &
	else
		runtabbed "$@"
	fi
fi

