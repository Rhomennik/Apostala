#!/usr/bin/env bash

##################################################################
### Configuraciones de bash para una buena programacion.
##################################################################
set -o errexit	#En el caso de erro que cierre el programa.
set -o nounset	#En el caso que tenga variable sin declarar.
set -o pipefail	#Para obtener el estado de salida de la ultima orden que arrojo un codigo de salida distinto a cero.
#set -o xtrace	#Para depurar encaso que hay errores.

## Variables
RUTA=$(cat variables | grep ruta | cut -d "=" -f2)

## Modulos externos.
SCREENSHOT="$RUTA/modulos/screenshot/screenshot.sh"
ULTRAVNC="$RUTA/modulos/ultravnc/ultravnc.sh"
## Lista de dependencias (Creamos el vector DEPENDENCIA[] para guardar las dependencias necesarios para el funcionamento del scritp).
DEPENDENCIA[0]=scrot	#Una pequena aplicacion para hacer screenshot de la pantalla.
DEPENDENCIA[1]=x11vnc	#Pequenho administrador de tareas en linea de codigo
#DEPENDENCIA[2]=nano	#Editor de texto
#DEPENDENCIA[3]=vim		#Editor de text
#DEPENDENCIA[4]=chrome	#Navegardor chrome
#DEPENDENCIA[5]=firefox	#Navegador firefox

##################################################################
### Verificacao de la lista de dependencia en el caso que haya.
##################################################################

##Variables
CANT_DEP=0	#Cantidad de dependencia - Contador para la lista de las dependencias.
CANT_INST=0	#Cantidad de instalados - Contador para dependencias que no estan instaladas.
LIST_DEP=vacio	#Lista de dependencias - Vector para armacenar dependencias no instaladas.
UNICA_VEZ=1
while [ $UNICA_VEZ -lt 3 ]
do
	echo "$UNICA_VEZ) Verificar las dependencias instalados."
	LIST_DEP=vacio  #Lista de dependencias - Vector para armacenar dependencias no instaladas.
	while [ $CANT_DEP -lt ${#DEPENDENCIA[*]} ]	#Verifica si hay programa para verificacion.
	do
		if [ $(which ${DEPENDENCIA[CANT_DEP]}) ]	#Condicion si esta instalado o no.
		then
       		 	echo -e "${DEPENDENCIA[CANT_DEP]} [\033[0;32mOK\033[0m]"	#Pone OK.
		else
        		echo -e "${DEPENDENCIA[CANT_DEP]} [\033[0;31mNO\033[0m]"	#Pone No.
			LIST_DEP[CANT_INST]=${DEPENDENCIA[CANT_DEP]}	#Agrega la dependencia no instalado al vector.
			CANT_INST=$(( $CANT_INST + 1 ))		#Contador de dependencias no instalados agrega mas uno.
		fi
		CANT_DEP=$(( $CANT_DEP + 1 ))		#Contador de la lista de todos las dependencias agrega mas uno.
	done

	##################################################################
	### Lista de dependencia no instaladas.
	##################################################################

	if [ "${LIST_DEP[0]}" != "vacio" ]	#Verifica si hay algun programa para LIST_DEP.
	then
	UNICA_VEZ=$(( UNICA_VEZ + 1 ))
	echo
		echo Instalar dependencia:
		apt update -y
		CANT_DEP=0	#Cera el contador 
		while [ $CANT_DEP -lt ${#LIST_DEP[*]} ]	#Verifica si hay programa para listar.
		do
			apt install ${LIST_DEP[CANT_DEP]} -y		#Lista el programa.
			CANT_DEP=$(( $CANT_DEP + 1 ))		#Contador de la listas de las dependencias que faltan instalar.
		done
	else
		UNICA_VEZ=3
	fi
echo
CANT_DEP=0      #Cantidad de dependencia - Contador para la lista de las dependencias.
CANT_INST=0     #Cantidad de instalados - Contador para dependencias que no estan instaladas.
done

if [ "${LIST_DEP[0]}" != "vacio" ]
then
	echo "No se pudo instalar las siguientes dependencias:"
	echo ${LIST_DEP[*]}
	exit 0
fi


##################################################################
### Inicio de modulos.
##################################################################
echo
echo "2) Iniciando modulos del sistema."

## Inicia x11vnc con la contrasenha default
source "$ULTRAVNC"
## Hace screenshot a cada timpo establecido y copia a la carpeta /tmp.
source "$SCREENSHOT"

