#!/usr/bin/python3
import subprocess
import time

TOKEN="Escriba aqui su token" # Rellenar con el Token 
ID_RECEPTOR="1552233" #Del estilo 1552233
#Obtenemos el status del servidor Apache2
comandoStatus="sudo systemctl status apache2 2>&1"

URL="https://api.telegram.org/bot"+TOKEN+"/sendMessage" #URL API Web, incluyendo Token
# Se requiere CURL instalado ("sudo apt-get install curl")

while(True):
	#Lanzo el comando y btengo salida normal y salida de error del comando ejecutado
	p = subprocess.Popen(comando, stdout=subprocess.PIPE, shell=True)
	(output, err) = p.communicate()
	MENSAJE=output.decode("utf-8")  #Paso de Bytes a String UTF8
	
	# Envia por Post a la URL dada, al chat con el usuario ID el mensaje
	comando="curl -s -X POST "+URL+" -d chat_id="+ID_RECEPTOR+" -d text='"+str(MENSAJE)+"'"
	#Lanzo el comando y btengo salida normal y salida de error del comando ejecutado
	p = subprocess.Popen(comando, stdout=subprocess.PIPE, shell=True)
	(output, err) = p.communicate()
	
	#Paramos 10 segundos
	time.sleep(10)