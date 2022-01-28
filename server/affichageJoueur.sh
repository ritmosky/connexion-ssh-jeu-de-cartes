#!/bin/bash

function getpts {
	echo $(who | grep $1 | cut -d" " -f3)
}

function echoPlayer {
	if [ -n $(getpts $1) ]
	then
		cat temp/$1In > "/dev/$(getpts $1)"
	fi
}

#echoPlayer $1

echo $1
echo $(getpts $1)

