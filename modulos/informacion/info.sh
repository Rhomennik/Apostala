#!/bin/bash
set -o xtrace
#sleep 15

# MAC=$(/sbin/ifconfig $INTERFACE | grep inet6 | head -n2 | cut -d " " -f10)
# MACDB=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_eth0 FROM info" | grep $MACETH0 |head -n1)
# MACDB1=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_wlan0 FROM info" | grep $MACWLAN0 |head -n1)

curl ifconfig.me > ippublica.txt

while [ true ]
do
IPMONGO=192.168.10.62:3000
INTERFACE=$(/sbin/route -n | grep '^0\.0\.0\.0' | head -n 1 | awk '{print $NF}')
MAC=$(cat /sys/class/net/$INTERFACE/address)
#MAC=$(ifconfig $INTERFACE | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | head -n1)
FOTO=$(echo $MAC | sed 's/://g')
UPTIME=$(uptime | cut -d " " -f4,5)
IPLOCAL=$(hostname -I)
IPPUBLICO=$(cat ippublica.txt | head -n1)

echo "############ BAIXANDO GET PARA VERIFICACOA DO MAC #############33"
echo "$MAC"
  curl -X GET \
  http://$IPMONGO/maquinas/$MAC \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 182e2b69-6651-4eb9-b042-59740ec36c71' \
  -H 'cache-control: no-cache' > buscandomac.txt
echo "BUSCANDO MAC"
FINDMAC=$(find buscandomac.txt -type f -exec grep -l $MAC {} \;)
IDMAQ=$(cat buscandomac.txt | head -n1 | cut -d '"' -f12)
echo "validacao se o mac e igual"
  if  [ $FINDMAC == buscandomac.txt ]
  then ## Si existe ejecutamos L26
   echo " Atualizando informaciones "
    curl -X PUT \
  http://$IPMONGO/maquinas/$IDMAQ \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 93b87e09-790e-4cd8-89b2-377c6cbb9929' \
  -H 'cache-control: no-cache' \
  -d "uptime=$UPTIME&mac=$MAC&iplocal=$IPLOCAL&ippublico=$IPPUBLICO"

echo "FUNCIONANDO TIROU IMAGEN AQUI EMBNAIXO LEGAL MEU DEUS"
curl -i -X PUT -H "Content-Type: multipart/form-data" -F "imagen=@/tmp/$FOTO-original.jpg" http://$IPMONGO/upload/maquinas/$IDMAQ


   else # Si no existe registramos, (new)
   echo " Creando nuevo registro"
	echo $FOTO
# Enviando a foto kk dps da info
#sudo ./ss.sh

curl -X POST \
  http://$IPMONGO/maquinas \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 80ab2f4c-b0f6-4cae-ae27-2aa4cdc76d11' \
  -H 'cache-control: no-cache' \
  -d "iplocal=$IPLOCAL&ippublico=$IPPUBLICO&uptime=$UPTIME&mac=$MAC&img=nuevo"

fi
echo " atualizado :D "
sleep 60
done
