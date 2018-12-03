#!/bin/bash
#set -o xtrace


# MAC=$(/sbin/ifconfig $INTERFACE | grep inet6 | head -n2 | cut -d " " -f10)
# MACDB=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_eth0 FROM info" | grep $MACETH0 |head -n1)
# MACDB1=$(mysql -h 142.93.2.182 -u ext -pRhome123# -D infopcs -e  "SELECT mac_wlan0 FROM info" | grep $MACWLAN0 |head -n1)

curl ifconfig.me > ippublica.txt

while [ true ]
do

IPMONGO=localhost:3000
INTERFACE=$(/sbin/route -n | grep '^0\.0\.0\.0' | head -n 1 | awk '{print $NF}')
MAC=$(ifconfig wlp3s0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | head -n1)
UPTIME=$(uptime | cut -d " " -f4,5)
IPLOCAL=$(ifconfig $INTERFACE | grep inet| head -n1 | cut -d " " -f10 | sed 's/addr://g')
IPPUBLICO=$(cat ippublica.txt | head -n1)

echo "############ BAIXANDO GET PARA VERIFICACOA DO MAC #############33"
  curl -X GET \
  http://localhost:3000/maquinas/$MAC \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 182e2b69-6651-4eb9-b042-59740ec36c71' \
  -H 'cache-control: no-cache' > buscandomac.txt
echo "BUSCANDO MAC"
FINDMAC=$(find buscandomac.txt -type f -exec grep -l $MAC {} \;)
IDMAQ=$(cat buscandomac.txt | head -n1 | cut -d '"' -f8)
echo "validacao se o mac e igual"
  if  [ $FINDMAC == buscandomac.txt ]
  then ## Si existe ejecutamos L26
   echo " Atualizando informaciones "
    curl -X PUT \
  http://localhost:3000/maquinas/$IDMAQ \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: a60024dc-9cce-4a24-99a4-d42243505458' \
  -H 'cache-control: no-cache' \
  -d "uptime=$UPTIME&Iplocal=$IPLOCAL&IPPUBLICO=$IPPUBLICO"

   else # Si no existe registramos, (new)
   echo " Creando nuevo registro"
curl -X POST \
  http://$IPMONGO/maquinas \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: 80ab2f4c-b0f6-4cae-ae27-2aa4cdc76d11' \
  -H 'cache-control: no-cache' \
  -d "iplocal=$IPLOCAL&ippublico=$IPPUBLICO&uptime=$UPTIME&macwlan0=$MAC&maclan0=null"
   echo "MAC NO EXISTE EN LA BASE DE DATOS"
fi
echo " atualizado :D "

sleep 5
done