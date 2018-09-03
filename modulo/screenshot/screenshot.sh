#!/usr/bin/env bash

##################################################################
### Configuraciones de bash para una buena programacion.
##################################################################
set -o errexit	#En el caso de erro que cierre el programa.
set -o nounset	#En el caso que tenga variable sin declarar.
set -o pipefail	#Para obtener el estado de salida de la ultima orden que arrojo un codigo de salida distinto a cero.
#set -o xtrace	#Para depurar encaso que hay errores.


while [ true ]
do
## Hace screenshot a cada timpo establecido y copia a la carpeta /tmp.
echo Nuevo screenshot.
scrot --thumb 50 -z 'pantalla.png' -e 'mv $m /tmp/pantalla.png && rm -rf $f'
sleep 5
done
