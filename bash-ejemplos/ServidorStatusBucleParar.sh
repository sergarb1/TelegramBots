#!/bin/bash

TOKEN="Escriba aqui su token" # Rellenar con el Token 
ID_RECEPTOR="1552233" #Del estilo 1552233
URL_SEND="https://api.telegram.org/bot$TOKEN/sendMessage" #URL API Web para enviar Mensaje
URL_UPDATE="https://api.telegram.org/bot$TOKEN/getUpdates" #URL API Web para recibir Mensajes 

#Inicialmente, estado desactivado, no envia notificaciones
estado="PARADO"

#Bucle infinito
while :
do
	#Coge los updates y los procesa para obtener la ultima orden recibida por el chat
	orden=$(curl -s -X POST $URL_UPDATE -d chat_id=$ID_RECEPTOR | sed -E 's/.*"text":"?([^,"]*)"?.*/\1/' | tail -1)
	
	#Si la ultima orden recibida es /empezar o /parar, cambia el estado
	if [ $orden = "/parar" ];
	then
		estado="PARADO"
	elif [ $orden  = "/empezar" ];
	then
		estado="FUNCIONANDO"
	fi

	#Enviamos el mensaje si el estado es funcionando
	if [ $estado = "FUNCIONANDO" ];
	then
		#Mensaje para obtener estado Apache2
		MENSAJE=`sudo systemctl status apache2 2>&1`
		#Enviamos el mensaje
		curl -s -X POST $URL_SEND -d chat_id=$ID_RECEPTOR -d text="$MENSAJE"
	fi
	#Duerme durante 3 segundos
	sleep 3
done
