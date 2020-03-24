#!/usr/bin/python3
import subprocess
import time

TOKEN="Escriba aqui su token" # Rellenar con el Token 
ID_RECEPTOR="1552233" #Del estilo 1552233
#Obtenemos el status del servidor Apache2
comandoStatus="sudo systemctl status apache2 2>&1"

URL_SEND="https://api.telegram.org/bot"+TOKEN+"/sendMessage" #URL API Web para enviar
URL_UPDATE="https://api.telegram.org/bot"+TOKEN+"/getUpdates" #URL API Web para leer

#Estado de los envios. Por defecto no se envia nada.
estado="PARADO"

while(True): 

	#Lanzo el comando y btengo salida normal y salida de error del comando ejecutado
	p = subprocess.Popen(comando, stdout=subprocess.PIPE, shell=True)
	(output, err) = p.communicate()
	ordenEstado=output.decode("utf-8")  #Paso de Bytes a String UTF8
	
	#Si la ultima orden recibida es /empezar o /parar, cambia el estado
	if ordenEstado=="/empezar":
		estado="FUNCIONANDO"
	elif ordenEstado=="/parar":
		estado="PARADO"

	#Enviamos el mensaje si el estado es funcionando
	if estado=="FUNCIONANDO":
		#Lanzo el comando y btengo salida normal y salida de error del comando ejecutado
		p = subprocess.Popen(comando, stdout=subprocess.PIPE, shell=True)
		(output, err) = p.communicate()
		MENSAJE=output.decode("utf-8")  #Paso de Bytes a String UTF8
		
		# Envia por Post a la URL dada, al chat con el usuario ID el mensaje
		comando="curl -s -X POST "+URL_SEND+" -d chat_id="+ID_RECEPTOR+" -d text='"+str(MENSAJE)+"'"
		#Lanzo el comando y btengo salida normal y salida de error del comando ejecutado
		p = subprocess.Popen(comando, stdout=subprocess.PIPE, shell=True)
		(output, err) = p.communicate()
		
	#Paramos 10 segundos
	time.sleep(10)
