#!/bin/bash

function getpts {
	who | grep $1 | cut -d" " -f3
}

function echoPlayer {
	cat temp/$1In > "/dev/$(getpts $1)"
}

echoPlayer $1
