#!/usr/bin/env bash
RUTA=$(cat ../variables | grep ruta | cut -d "=" -f2)
RUTASED=$(echo $RUTA | sed  's/\//\\\//g')

instalar() {
	echo "Instalando apostala-server..."
	mkdir -p ~root/.vnc		## Creando carpeta para ultravcn
	mkdir -p $RUTA
	sed "s/variables/$RUTASED\/variables/" ../apostala.sh > $RUTA/apostala.sh
	chmod +x $RUTA/apostala.sh
	cp -r ../modulos $RUTA/
	cp ../variables $RUTA/
	sed "s/variables/$RUTASED\/variables/" ../apostala-server | sed "s/$\RUTA/$RUTASED/"> /etc/init.d/apostala-server
	chmod +x /etc/init.d/apostala-server
	update-rc.d apostala-server defaults
	#Definiendo foto de BK (WALLPAPER)
	echo "[OK]"
}
desinstalar() {
	echo "Desistalando apostala-server..."
	rm -rf $RUTA/
	update-rc.d -f apostala-server remove
	rm -rf /etc/init.d/apostala-server
	echo "[OK]"
}
	case "$1" in
	-i) instalar
	;;
	-d) desinstalar
	;;
	*) echo -e "Utilize uno de los dos exemplos:\nsudo $0 -i (para instalar)\nsudo $0 -d (para desinstalar"
	;;
	esac
