


#Fonction qui rajoute la carte jouée par joueurActuel dans le fichier etatJeu
function jouerCarte {
    echo "$1 $2" >> etatJeu.txt
}



function tourDeJeu {
    JoueurActuel=$1 


    ./AffichageJoueur.sh $JoueurActuel

    cat /dev/null > temp/"${JoueurActuel}Out"

    while [ ! $(cat temp/${JoueurActuel}Out) ] 
    do
        carte=$(cat temp/${JoueurActuel}Out)
    done

    cat /dev/null > temp/"${JoueurActuel}Out"
    sed '/$carte/d' "temp/${JoueurActuel}In" > "temp/${JoueurActuel}In"
    jouerCarte $joueurActuel $carte

    


}

for i in {1..7}
do
    for joueur in $(ls listeJoueurs)
    do
        tourDeJeu $joueur
    done

    maximum=$(cat etatJeu.txt | tr -s ' ' '\n' | grep -v Player* | sort -rn | head --lines=1)
    joueurGagnant=$(cat etatJeu.txt | grep $maximum | cut -d ' ' -f 1)
    $"{$JoueurGagnant}_score"=$(($"{$JoueurGagnant}_score"+1))
    #cat etatJeu.txt >> $(cat etatJeu.txt | tr -s ' ' '\n' | grep -v Player*)
done