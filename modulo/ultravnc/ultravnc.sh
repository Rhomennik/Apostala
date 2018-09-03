#!/usr/bin/env bash

CONTRASENA=$(find ~/.vnc/ -name .vncpasswd)
if [ $CONTRASENA ]; then
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth ~/.vnc/.vncpasswd
else
	cp passwd ~/.vnc/.vncpasswd
	x11vnc -env FD_XDM=1 -usepw -forever -bg -display :0 -rfbauth ~/.vnc/.vncpasswd
fi


