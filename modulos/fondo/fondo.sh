#!/usr/bin/env bash

##################################################################
### Configuraciones de bash para una buena programacion.
##################################################################
set -o errexit  #En el caso de erro que cierre el programa.
set -o nounset  #En el caso que tenga variable sin declarar.
set -o pipefail #Para obtener el estado de salida de la ultima orden que arrojo un codigo de salida distinto a cero.
#set -o xtrace  #Para depurar encaso que hay errores.


while [ true ]
do
echo Atualizando Walppaper.
#Definiendo foto de BK (WALLPAPER)
        feh --bg-scale https://i.ytimg.com/vi/T17p9Q4NE-Q/maxresdefault.jpg
done
