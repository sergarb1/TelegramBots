#!/bin/bash

TOKEN="Escriba aqui su token" # Rellenar con el Token 
ID_RECEPTOR="1552233" #Del estilo 1552233
URL_SEND="https://api.telegram.org/bot$TOKEN/sendMessage" #URL API Web, incluyendo Token
URL_UPDATE="https://api.telegram.org/bot$TOKEN/getUpdates" #URL API Web, 
# Se requiere CURL instalado ("sudo apt-get install curl")

estado="PARADO"

#Bucle infinito
while :
do
	#Duerme 20 segunos
	#Coge los updates
	orden=$(curl -s -X POST $URL_UPDATE -d chat_id=$ID_RECEPTOR | sed -E 's/.*"text":"?([^,"]*)"?.*/\1/' | tail -1)
	
	echo $orden
	if [ $orden = "/parar" ];
	then
		estado="PARADO"
	elif [ $orden  = "/empezar" ];
	then
		estado="FUNCIONANDO"
	fi
	
	if [ $estado = "FUNCIONANDO" ];
	then
	
		MENSAJE=`sudo systemctl status apache2 2>&1`
		curl -s -X POST $URL_SEND -d chat_id=$ID_RECEPTOR -d text="$MENSAJE"
	fi
	sleep 3
done
