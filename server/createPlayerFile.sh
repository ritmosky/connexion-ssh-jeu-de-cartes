#!/bin/bash

#rm /home/jimmy/jeu_cartes_ssh/server/temp/player*
file=$(cat "temp/jimmyOut")
echo $file

nbplayer=$1

for i in $(seq 1 $nbplayer)
do
	echo $i
	touch /home/jimmy/jeu_cartes_ssh/server/temp/ player"$i"Out
	touch /home/jimmy/jeu_cartes_ssh/server/temp/ player"$i"In
done
