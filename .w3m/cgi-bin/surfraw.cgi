#!/bin/sh

if [ -f /tmp/search ]; then
	echo "w3m-control: GOTO $(cat /tmp/search)"
	rm /tmp/search
else
	echo "w3m-control: BACK"
fi
