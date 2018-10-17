#!/bin/bash
#Variables de coneccion
IP="142.93.2.182"
SENHA="Rhome123#"
USUARIO="ext"
### Variaveis para insertacoes
USERS=$(uptime | cut -d " " -f4)
INTERFACE=$(/sbin/route -n | grep '^0\.0\.0\.0' | head -n 1 | awk '{print $NF}')
MAC=$(/sbin/ifconfig $INTERFACE | sed -n '1 p'| awk '{print $5}')
MACDB=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT macaddres FROM info" | grep $MAC | head -n1)

if [ $MAC == $MACDB ]
then ## reemplaza el valor uptime del macaddres de la maquina
	mysql -h $IP -u $USUARIO -p$SENHA -D infopcs -e \ "UPDATE info SET uptime = '$USERS' where macaddres='$MACDB'";
else ## si no existe el macaddres el agrega a la tabla
	mysql -h $IP -u $USUARIO -p$SENHA -e \ "INSERT INTO info (uptime, macaddres) values ('$USERS', '$MAC')" infopcs
fi


#MAC=$(ifconfig | grep HW | head -n1 | cut -d " " -f11)
#mysql -h $IP -u $USUARIO -p$SENHA -e \ "INSERT INTO info (uptime, macaddres) values ('$USERS', '$MAC')" infopcs
#mysql -h $IP -u $USUARIO -p$SENHA -e  "SELECT * FROM INFO"
