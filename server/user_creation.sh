#!/bin/bash

script_name=$0

function get_player_number {
    read -p "Entrer le nombre de joueurs: " nb_player
    echo $nb_player > temp/nb_player.dat
    echo
}

function echo_players {
    echo $(cut -d: -f1 /etc/passwd | grep player)
    echo
}

function create_users {
    nb_player=$(cat temp/nb_player.dat)
    for i in $(seq 1 $nb_player)
    do
        name="player$i"
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $name)
        echo "[Creating] $name"
        useradd --no-create-home $name -p $pass
    done
    echo_players
}
    
function delete_users {
    nb_player=$(cat temp/nb_player.dat)
    for i in $(seq 1 $nb_player)
    do
        echo "[Deleting] player$i"
        userdel "player$i"
    done
    echo_players
}

if [ "$1" = "create" ]
then
    create_users
elif [ "$1" = "remove" ]
then
    delete_users
elif [ "$1" = "player" ]
then
    get_player_number
else
    echo "Argument manquant:"
    echo "Ex:" $script_name "create"
    echo "Ex:" $script_name "remove"
    exit 0
fi