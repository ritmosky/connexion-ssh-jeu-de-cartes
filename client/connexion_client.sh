#!/bin/bash


# la fonction prend en entrée l'adresse du serveur et le nom du jouer
# vérifie si le username existe déjà, dans le cas échéant le client pourra se connecter au serveur

# $1 = username
# $2 = adresse du serveur

chmod 777 login_user.dat	# on accorde les droits

##########################################################

# si adresse existe maisusername n'esxist pas
# fonction vérifie d'abord si le username existe

function est_dans_login_user {
	n=1
	m=4
	while [ $n -gt 0 ] && [ "$m" -gt 0 ]
	do
		for i in $(cat login_user.dat)
		do
			if [ "$1" = "$i" ]
			then
				n=$(($n-1))
			fi
			m=$(($m-1))
		done
	done

	if [ $n -eq 0 ]
	then
		echo "1"  # si joueur existe on retourne 1

	else
		echo "0" # sinon on retourne 0
	fi
}



est_dans_login_user $1 $2


##########################################################

function connexion_c {
	# si le username est disponible alors on établit la connexion
	if [ $(est_dans_login_user $1) -eq 1 ]
	then
		#ssh $2@$1 

		# et on rajoute le login dans fichier login 
		echo -e "$1" >> login_utilise
		echo "1"
	else 
		# relancer le processus, on affiche les logins possibles
		echo "voici la liste des logins"
		for i in $(cat login_user.dat)
		do
			echo "$i"
		done
	fi
}

connexion_c $1 $2

