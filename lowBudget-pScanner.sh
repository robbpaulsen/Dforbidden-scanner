#!/usr/bin/env bash
## set -e
##################################################################################################################
## Author    : robbpaulsen
## Website   : https://www.github.com
##################################################################################################################
## tput setaf 0 = black
## tput setaf 1 = red
## tput setaf 2 = green
## tput setaf 3 = yellow
## tput setaf 4 = dark blue
## tput setaf 5 = purple
## tput setaf 6 = cyan
## tput setaf 7 = gray
## tput setaf 8 = light blue
##################################################################################################################

ctrl_c() {
	tput setaf 3
	echo "Saliendo ..."
	tput sgr 0
	sleep 2
	exit
}
trap ctrl_c INT

get_target() {
	echo ""
	tput setaf 6
	read -p "Indica la direccion target: " host
	sleep 2
	echo ""
	echo ""
	read -p "Indica que puerto revisar: " port
	sleep 2
	tput sgr 0
}

loop() {
	2>/dev/null exec 3<>/dev/tcp/$host/$port
}

resolve() {
	if [[ $? -eq 0 ]]; then
		echo ""
		tput setaf 2
		echo -e "\n\t[+] El puerto $port de la direccion $host esta abierto\n"
		tput sgr 0
	else
		echo ""
		echo ""
		tput setaf 3
		echo -e "\n\t[!] El puerto $port de la direccion $host esta cerrado\n"
		tput sgr 0
	fi
	exec 3>&-
}

get_target
loop
resolve
