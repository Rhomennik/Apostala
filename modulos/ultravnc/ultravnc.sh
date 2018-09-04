#!/usr/bin/env bash
RUTA=$(cat ../../variables | grep ruta | cut -d "=" -f2)
CONTRASENA=$(find ~/.vnc/ -name .vncpasswd)
if [ $CONTRASENA ]; then
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth ~/.vnc/.vncpasswd
else
	cp $RUTA/passwd ~/.vnc/.vncpasswd
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth ~/.vnc/.vncpasswd
fi


