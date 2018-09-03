#!/usr/bin/env bash
RUTA="/opt/apostala"
mkdir -p $RUTA
cp apostala.sh $RUTA/
cp -r ../modulos $RUTA/ 
cp ../apostala-server /etc/init.d/
update-rc.d apostala-server defaults
