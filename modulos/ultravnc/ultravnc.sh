#!/usr/bin/env bash
RUTA=$(cat /opt/apostala/variables | grep ruta | cut -d "=" -f2)
CONTRASENA=$(find ~root/.vnc/ -name .vncpasswd)
if [ $CONTRASENA ]; then
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth -auth guess ~root/.vnc/.vncpasswd
else
	cp $RUTA/modulos/ultravnc/passwd ~root/.vnc/.vncpasswd
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth -auth guess ~root/.vnc/.vncpasswd
fi


