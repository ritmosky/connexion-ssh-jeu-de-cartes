#!/bin/bash

script_name=$0

function get_player_number {
    read -p "Entrer le nombre de joueurs: " export $nb_player
}

function create_users {
    for i in {1, $nb_player}
    do
        useradd "player$nb_player"
    do
}
    
function remove_users {
    for i in {1, $nb_player}
    do
        userdel -r "player$nb_player"
    done
}

if [ "$1" = "create" ]
then
    get_player_number
    create_users
elif [ "$1" = "remove" ]
then
    remove_users
else
    echo "Argument manquant:"
    echo "Ex:" $script_name "create"
    echo "Ex:" $script_name "remove"
    exit 0
fi