#!/bin/bash
#source connexion_client.sh

# la fonction prend en entrée l'adresse du serveur et le nom du jouer
# vérifie si le username est déjà pris(cad est present une fois dans le fichier sans la dernière ligne, 
# dans le cas échéant le serveur laissera le client dans le jeu
# sinon il bloque le processus et vire le joueur

# $1 = login
# $2 = adresse

# chmod 777 login_utilise


##########################################################

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

function est_dans_login_joueur {
	n=1
	m=4
	while [ $n -gt 0 ] && [ "$m" -gt 0 ]
	do
		for i in $(cat login_joueur)
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


est_dans_login_joueur $1 $2

##########################################################


# dès qu'on trouve un login qui est égal au paramètre d'entrée alors on arrête le process
function login_used {
	n=1
	m=4


	while [ "$n" -gt 0 ] && [ "$m" -gt 0 ]
	do
		for i in $(head -n $(($(wc -l login_user.dat | cut -d" " -f8))) login_user.dat) #on lit tt sauf la derniere lign
		do
			if [ "$1" = "$i" ]
			then
				#echo $i
				n=$(($n-1))
			fi
			m=$(($m-1))
		done
	done

	if [ $n -eq 0 ] # est dans le fichier
	then
		echo "1" 

	else # n'est pas dans le fichier
		echo "0"

	fi
}

login_used $1 $2


##########################################################

function peut_jouer {
	# si le login en argument n'est pas utilisé et si il existe dans les users crées alors on l'ajouter
	if [ $(est_dans_login_user $1) -eq 1 ] && [ $(login_used $1) -eq  0 ] && [ $(est_dans_login_joueur $1) -eq  1 ]
	then
		echo -e "$1" >> login_joueur
	fi
}


peut_jouer $1 $2


##########################################################

function connexion_s {
	
	if [ $(login_used $1) -eq 0 ]  # si le login n'est pas utilisé alors on laisse le joueur continuer
	then
		echo "1"

	else		# sinon on lui propose un autre login et on bloque son entrée
		for i in $(head -n $(($(wc -l login_user.dat | cut -d" " -f8))) login_user.dat)
		do
			if [ $(login_used $i) -eq 0 ]
			then
				echo "essayer plutot $i"
			fi
		done
	fi
}	


connexion_s $1 $2


