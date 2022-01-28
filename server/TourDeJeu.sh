#!/bin/bash


#Fonction qui rajoute la carte jouée par joueurActuel dans le fichier etatJeu
function jouerCarte {
    echo "$1 $2" >> etatJeu.txt
}

function scoreCarte {
    carteJouee=$1
    case ${carteJouee:1:1} in

        ♣)
        coeff=100
        ;;

        ♦)
        coeff=125
        ;;

        ♥)
        coeff=150
        ;;

        ♠)
        coeff=175
        ;;

        *)
        echo Erreur
        ;;

    esac

    case ${carteJouee:0:1} in

        J)
        nombre=11
        ;;

        Q)
        nombre=12
        ;;

        K)
        nombre=13
        ;;

        A)
        nombre=14
        ;;

        *)
        nombre=${carteJouee:0:1}
        ;;

    esac

    echo $((nombre*coeff))
}

function tourDeJeu {
    JoueurActuel=$1 


    ./AffichageJoueur.sh $JoueurActuel

    cat /dev/null > temp/${JoueurActuel}Out

    while [ ! $(cat temp/${JoueurActuel}Out) ] 
    do
        echo
    done

    carte=$(cat temp/${JoueurActuel}Out)

    cat /dev/null > temp/${JoueurActuel}Out
    sed /$carte/d temp/${JoueurActuel}In > temp/${JoueurActuel}In2.txt
    cat temp/${JoueurActuel}In2.txt > temp/${JoueurActuel}In.txt
    rm temp/${JoueurActuel}In2.txt
    carte=$(scoreCarte $carte)
    jouerCarte $joueurActuel $carte

}

nbJoueurs=$(cat temp/nb_player.dat)
declare -a score

for i in {1..7}
do
    for j in {1..$nbJoueurs}
    do
        tourDeJeu "Player$j"
    done

    maximum=$(cat etatJeu.txt | tr -s ' ' '\n' | grep -v Player* | sort -rn | head --lines=1)
    joueurGagnant=$(cat etatJeu.txt | grep $maximum | cut -d ' ' -f 1)
    numeroGagnant=${JoueurGagnant:6:1}
    score[$numeroGagnant]=$((${score[$numeroGagnant]}+1))

done

for p in {1..$nbJoueurs}
do  
    echo "Player$p ${score[p]}" >> temp/resultatsFinaux.txt
done

scoreMaximum=$(cat temp/resultatsFinaux.txt | tr -s ' ' '\n' | grep -v Player* | sort -rn | head --lines=1)
gagnant=$(cat temp/resultatsFinaux.txt | grep $scoreMaximum | cut -d ' ' -f 1)

wall "Le gagnant de la partie est $gagnant avec $scoreMaximum points !!"
