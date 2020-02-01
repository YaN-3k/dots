#!/usr/bin/env sh

# dmenu prompts
TYPE="$(printf "Screen\nWindow/Area\n" | dmenu -i -p 'What do you want to screenshot?')"
if [ -z "$TYPE" ]; then exit; fi
SAVE="$(printf "No\nYes"               | dmenu -i -p 'Do you want to copy to clipboard?')"
if [ -z "$SAVE" ]; then exit; fi
TIME="$(printf "0.7\n5\n10\n15"        | dmenu -i -p 'How many seconds you want to wait?')"
if [ -z "$TIME" ]; then exit; fi

# Set flag if selected "Window"
case "$TYPE" in
	Window/Area) TYPE="-s -u";;
	*)           TYPE=""
esac

# Prepere for screenshot
mkdir "$(xdg-user-dir PICTURES)"/Screenshot
sleep "$TIME"

# Copy to clipboard or save to file
case "$SAVE" in
	Yes) maim $TYPE | xclip -selection clipboard -t image/png;;
	*)   maim $TYPE "$(xdg-user-dir PICTURES)"/Screenshot/"$(date +%G-%m-%d_%s.png)"
esac
