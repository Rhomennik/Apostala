#!/bin/bash
#set -o xtrace
#Criando o arquivo publico
curl ifconfig.me > ippublica.txt
#INSERT INTO images (description,image)VALUES('leste',LOAD_FILE('/tmp/7085c2590bcc.jpg'));
while [ true ]
do
#Variables de coneccion
IP="142.93.2.182"
SENHA="Rhome123#"
USUARIO="ext"
### Variaveis para insertacoes
UPTIME=$(uptime | cut -d " " -f4,5)
INTERFACE=$(/sbin/route -n | grep '^0\.0\.0\.0' | head -n 1 | awk '{print $NF}')
MACWLAN0=$(/sbin/ifconfig wlan0 | sed -n '1 p'| awk '{print $5}')
MACETH0=$(/sbin/ifconfig eth0 | sed -n '1 p'| awk '{print $5}')
MACDB=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_eth0 FROM info" | grep $MACETH0 |head -n1)
MACDB1=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_wlan0 FROM info" | grep $MACWLAN0 |head -n1)
IPLOCAL=$(ifconfig wlan0 | grep inet| head -n1 | cut -d " " -f12 | sed 's/addr://g')
# Lendo arquivo #
IPPUBLICA=$(cat ippublica.txt | head -n1)
echo "INiciando verificacion MYSQL"
if [ $MACETH0 == $MACDB ]
then ## SI ja existe
	mysql -h $IP -u $USUARIO -p$SENHA -D infopcs -e \ "UPDATE info SET uptime = '$UPTIME',iplocal= '$IPLOCAL', ippublica= '$IPPUBLICA' where mac_eth0= '$MACETH0';"
elif [ $MACWLAN0 == $MACDB1 ]
then
	mysql -h $IP -u $USUARIO -p$SENHA -D infopcs -e \ "UPDATE info SET uptime = '$UPTIME',iplocal= '$IPLOCAL', ippublica= '$IPPUBLICA' where mac_wlan0= '$MACWLAN0'"
else ## si no existe
mysql -h $IP -u $USUARIO -p$SENHA -e \ "INSERT INTO info (mac_eth0, uptime,  mac_wlan0 , iplocal, ippublica) values ('$MACETH0', '$UPTIME', '$MACWLAN0','$IPLOCAL', '$IPPUBLICA')" infopcs
fi
sleep 1m
done
#MAC=$(ifconfig | grep HW | head -n1 | cut -d " " -f11)
#mysql -h $IP -u $USUARIO -p$SENHA -e \ "INSERT INTO info (uptime, macaddres) values ('$USERS', '$MAC')" infopcs
#mysql -h $IP -u $USUARIO -p$SENHA -e  "SELECT * FROM INFO"

