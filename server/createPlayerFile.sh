#!/bin/bash

rm /home/jimmy/jeu_cartes_ssh/server/temp/playerOut*
rm /home/jimmy/jeu_cartes_ssh/server/temp/playerIn*


nbplayer=$1

for i in $(seq 1 $nbplayer)
do
	echo $i
	touch /home/jimmy/jeu_cartes_ssh/server/temp/playerOut$i
	touch /home/jimmy/jeu_cartes_ssh/server/temp/playerIn$i 
done
