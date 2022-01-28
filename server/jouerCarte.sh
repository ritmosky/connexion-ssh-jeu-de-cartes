#!/bin/bash
# ce fichier permet au joueur de jouer sa carte et rediriger sa commande vers un fichier qui
#sera lu par le serveur


nomPlayer=$(whoami)
echo $nomPlayer

if grep -Fxq "$1" listeCartes.txt
then
	echo "$1" > temp/"$nomPlayer"Out
	echo "Ok vous avez jouer $1"
else
	echo "Ce choix n est pas valide, recommencez : "
fi
 
