#!/bin/bash

script_name=$0

function get_player_number {
    read -p "Entrer le nombre de joueurs: " NB_PLAYER
    echo
    export NB_PLAYER
}

function echo_players {
    echo $(cut -d: -f1 /etc/passwd | grep player)
    echo
}

function create_users {
    for i in $(seq 1 $NB_PLAYER)
    do
        name="player$i"
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $name)
        echo "[Creating] $name"
        useradd --no-create-home $name -p $pass
    done
    echo_players
}
    
function delete_users {
    for i in $(seq 1 $NB_PLAYER)
    do
        echo "[Deleting] player$i"
        userdel "player$i"
    done
    echo_players
}

if [ "$1" = "create" ]
then
    get_player_number
    create_users
elif [ "$1" = "remove" ]
then
    get_player_number
    delete_users
else
    echo "Argument manquant:"
    echo "Ex:" $script_name "create"
    echo "Ex:" $script_name "remove"
    exit 0
fi