#!/bin/bash

function creation_fichier {
	rm -f temp/player*
	if [ -e "temp/nb_player.dat" ]
	then
		nbplayer=$(cat "temp/nb_player.dat")
	else
		nbplayer=0
	fi
	for i in $(seq 1 $nbplayer)
	do
		touch temp/player"$i"Out
		touch temp/player"$i"In
	done
	if [ -e "temp/player*Out" ]
	then
		chmod 666 temp/player*Out
	fi
	init_fichier_in
	echo "Fichiers d echanges crees"
	echo
}

function init_fichier_in {
for file in temp/player*In
do
	echo C est a ton tour de jouer ! Tape '"./jouerCarte "tacarte" "' pour pouvoir jouer. Voici tes cartes : > $file
done
}

if [ "$1" = "remove" ]
then 
	rm -f temp/player*
else
	creation_fichier
fi
