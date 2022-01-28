#!/bin/bash

script_name=$0
ssh_status=$(dpkg -s ssh | grep "Status:")
ssh_server_status=$(dpkg -s openssh-server | grep "Status:")
mcrypt_status=$(dpkg -s mcrypt | grep "Status:")

function get_ssh_server_status {
	if [ "$(service --status-all | grep ssh)" = " [ + ]  ssh" ]
        then
        	echo 1
        elif [ "$(service --status-all | grep ssh)" = " [ - ]  ssh" ]
        then
            echo 0
        else
            echo -1
        fi
}

function print_ssh_server_status {
	if [ $(get_ssh_server_status) -eq 1 ]
	then
		echo "[✓] ssh server is on"
	elif [ $(get_ssh_server_status) -eq 0 ]
	then
		echo "[✓] ssh server is off"
	else
		echo "$(service --status-all | grep ssh)"
	fi

	echo
}

if [ "$ssh_status" = "Status: install ok installed" ]
then
	echo "[✓] ssh"
else
	echo "[X] ssh"
	echo "[installing] ssh"
	apt install ssh
fi

if [ "$ssh_server_status" = "Status: install ok installed" ]
then
    echo "[✓] openssh-server"
else
    echo "[X] openssh-server"
    echo "[installing] openssh-server"
    apt install openssh-server
fi

if [ "$mcrypt_status" = "Status: install ok installed" ]
then
	echo "[✓] mcrypt"
else
	echo "[X] mcrypt"
	echo "[installing] mcrypt"
	apt install mcrypt
fi

echo

if [ "$1" = "start" ]
then
	sudo systemctl start ssh
	echo "[✓] serveur ssh démarré"
	print_ssh_server_status
	ip=$(ifconfig | grep "inet.*broadcast" | cut -d" " -f10)
	echo "IP du serveur: $ip"
    bash ./user_creation.sh create
elif [ "$1" = "stop" ]
then
    sudo systemctl stop ssh
    echo "[✓] serveur ssh éteint"
    print_ssh_server_status
    bash ./user_creation.sh remove
else
    echo "Argument manquant:"
    echo "Ex:" $script_name "start"
    exit 0
fi
