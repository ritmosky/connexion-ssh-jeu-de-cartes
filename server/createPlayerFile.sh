#!/bin/bash

rm temp/player*
file=$(cat "temp/jimmyOut")
echo $file

nbplayer=$1

for i in $(seq 1 $nbplayer)
do
	echo $i
	touch temp/player"$i"Out
	touch temp/player"$i"In
done

chmod 666 temp/player*Out
