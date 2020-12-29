#!/bin/sh

if [ -z "$QUERY_STRING" ]; then
	echo "Error: No URI"
	exit 1
fi

torradd "$QUERY_STRING"

if [ -n "$HTTP_REFERER" ]; then
	echo "HTTP/1.1 See Other"
	echo "Location: $HTTP_REFERER"
else
	echo "w3m-control: BACK"
fi
