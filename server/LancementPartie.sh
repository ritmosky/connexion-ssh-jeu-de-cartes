nbJoueurs=$(cat temp/nb_player.dat)
cp listeCartes.txt temp/listeTemp.txt

function piocher {  #Joueur ; Nombre de cartes
    numeroCartePiochee=$((1 + $RANDOM % $2))
    cartePiochee=$(sed "${numeroCartePiochee}q;d" temp/listeTemp.txt)
    echo $cartePiochee >> temp/${1}In
    sed ${cartePiochee}d temp/listeTemp.txt > temp/listeTemp2.txt
    cat temp/listeTemp2.txt > temp/listeTemp.txt
    rm temp/listeTemp2.txt
}

for i in {1..nbJoueurs}
do
    for j in {1..7}
    do  
        piocher Player$i $(wc -l temp/listeTemp.txt | awk '{ print $1 }')
done

./TourDeJeu.sh