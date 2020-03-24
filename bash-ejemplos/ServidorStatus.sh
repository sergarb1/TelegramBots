#!/bin/bash

TOKEN="Escriba aqui su token" # Rellenar con el Token 
ID_RECEPTOR="1552233" #Del estilo 1552233
#Genera el mensaje sobre el estado de apache2
MENSAJE=`sudo systemctl status apache2 2>&1`
URL="https://api.telegram.org/bot$TOKEN/sendMessage" #URL API Web, incluyendo Token

# Se requiere CURL instalado ("sudo apt-get install curl")
# Envia por Post a la URL dada, al chat con el usuario ID el mensaje
curl -s -X POST $URL -d chat_id=$ID_RECEPTOR -d text="$MENSAJE"
