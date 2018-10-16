#!/usr/bin/env bash
set -o xtrace
RUTA=$(cat ../variables | grep ruta | cut -d "=" -f2)
RUTASED=$(echo $RUTA | sed  's/\//\\\//g')


#sed "s/variables/$RUTASED\/variable/" ../apostala.sh



if [ $(apt search imagemagick | grep imagemagick/ | grep installed)  ]
then
	echo instalado.
fi
