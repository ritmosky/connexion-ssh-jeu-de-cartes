#!/bin/bash

nbJoueurs=$(cat temp/nb_player.dat)
cat listeCartes.txt > temp/listeTemp.txt
touch temp/listeTemp2.txt

function piocher {  #Joueur ; Nombre de cartes
    numeroCartePiochee=$((1 + $RANDOM % $2))
    cartePiochee=$(sed "${numeroCartePiochee}q;d" temp/listeTemp.txt)
    echo $cartePiochee >> temp/${1}In
    #sed -i "${numeroCartePiochee}q;d" temp/listeTemp.txt #> temp/listeTemp2.txt
    #cat temp/listeTemp2.txt > temp/listeTemp.txt
    #rm temp/listeTemp2.txt
}

for i in $(seq 1 $nbJoueurs) 
do
   	for j in {1..7}
    	do  
        	piocher player$i $(wc -l temp/listeTemp.txt | awk '{ print $1 }')
	done
done

bash ./TourDeJeu.sh
