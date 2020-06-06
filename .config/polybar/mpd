#!/bin/sh
status="$(mpc status 2>/dev/null | grep -oP '(pause|playing)')"
[ "$status" = "playing" ] &&
	echo "%{F#161821}%{T2}░▒▓█%{T-}%{F-}%{B#161821}%{F#84A0C6} %{F-} $(mpc current)%{B-}%{F#161821}%{T2}█▓▒░%{T-}%{F-}"
