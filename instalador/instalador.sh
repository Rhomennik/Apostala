#!/usr/bin/env bash
RUTA=$(cat ../variables | grep ruta | cut -d "=" -f2)
RUTASED=$(echo $RUTA | sed  's/\//\\\//g')

instalar() {
	echo "Instalando apostala-server..."
	mkdir -p ~root/.vnc		## Creando carpeta para ultravcn
	mkdir -p $RUTA
	sed "s/variables/$RUTASED\/variables/" ../apostala2.sh > $RUTA/apostala2.sh
	chmod +x $RUTA/apostala2.sh
	cp -r ../modulos $RUTA/
	cp ../variables $RUTA/
#	sed "s/variables/$RUTASED\/variables/" ../apostala-server | sed "s/$\RUTA/$RUTASED/"> /etc/init.d/apostala-server
#	sed "s/variables/$RUTASED\/variables/" ../apostala-inicio | sed "s/$\RUTA/$RUTASED/"> /etc/init.d/apostala-inicio
#	chmod +x /etc/init.d/apostala-server
#	chmod +x /etc/init.d/apostala-inicio
#	update-rc.d apostala-inicio defaults
#	rm -rf /etc/rc6.d/K20apostala-inicio
	mv rc.local /etc/.
	iptables -A INPUT -p tcp --dport 5900 -j ACCEPT
	cp -r ../themes /lib/plymouth/
	update-initramfs -u
	mv ../rc.xml ~/.config/openbox/
	echo "[OK]"
}
desinstalar() {
	echo "Desistalando apostala-server..."
	rm -rf $RUTA/
	update-rc.d -f apostala2.sh remove
	update-rc.d -f apostala-inicio remove
	rm -rf /etc/init.d/apostala-server
	rm -rf /etc/init.d/apostala-inicio
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
