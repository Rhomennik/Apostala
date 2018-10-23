#!/bin/bash
set -o xtrace
while [ true ]
do
VERIFI=$(ps -ejH | grep chromium-browse | cut -d " " -f18 | head -n1) # CHROMIUM ESTA ACTIVO ?
OPENBOX=$(ps -ejH | grep openbox | cut -d " " -f22 | head -n1) # OPENBOX ESTA ACTIVO?

if [ $VERIFI > /dev/null ] # se o proceso chromium esta ativo agente da um echo
then
	echo "Ya esta activo el chromium "
elif [ $OPENBOX > /dev/null  ] # modo grafico esta ativo ?
then
	sudo -H -u apostala DISPLAY=:0 chromium-browser --incognito aposta.la  mismarcadores.com bet365.com
else 				# e se nao esta ativo a gente ligao chromium
	echo "O pc ta ligando ainda"
fi
done
