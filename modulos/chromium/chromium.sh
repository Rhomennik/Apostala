#!/bin/bash
#sleep 10
set -o xtrace
pkill -f chromium-browser
pkill -f chromium-browser
while [ true ]
do
VERIFI=$(ps -e | grep "chromium-browse" | cut -d " " -f12 | head -n1) # CHROMIUM ESTA ACTIVO ?
OPENBOX=$(ps -ejH | grep openbox | cut -d " " -f22 | head -n1) # OPENBOX ESTA ACTIVO?
JATA=$(ps -ax | grep chromium.sh | grep -v grep | head -n1 | cut -d " " -f19)
if [ $JATA == /opt/apostala/modulos/chromium/chromium.sh ]
then
	echo "ta ativo script nao faca nada"

elif [ $VERIFI > /dev/null ] # se o proceso chromium esta ativo agente da um echo
then
	echo "Ya esta activo el chromium "
elif [ $OPENBOX > /dev/null  ] # modo grafico esta ativo ?
then
	sudo -H -u apostala DISPLAY=:0 chromium-browser --start-maximized --incognito aposta.la  mismarcadores.com bet365.com
else 				# e se nao esta ativo a gente ligao chromium
	echo "O pc ta ligando ainda"
fi
done
