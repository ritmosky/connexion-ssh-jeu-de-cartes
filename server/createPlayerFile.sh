#!/bin/bash

rm temp/player*
nbplayer=$(cat "temp/nb_player.dat")


for i in $(seq 1 $nbplayer)
do
	echo $i
	touch temp/player"$i"Out
	touch temp/player"$i"In
done

chmod 666 temp/player*Out

if [ $1 = "remove" ]
then 
	rm temp/player*
fi
