#!/bin/bash

while [ true ]
do
rm -rf /tpm/novo
set -o xtrace
#Precose
git clone https://github.com/rhomennik/Apostala /tpm/novo
sleep 5
# Variaveis
MD5=$(md5sum /tpm/novo/release.txt | cut -d " " -f1)
MD5ATUAL=$(md5sum /opt/apostala/release.txt | cut -d " " -f1)
PING=$(ping -c1 google.com &> ping.txt)
PINGG=$(cat ping.txt | cut -d " " -f4)
# =======
# Script=
# =======


echo "ate aqui"
if [ $PINGG == google.com ]
then
"n tem net"
elif [ $MD5 != $MD5ATUAL  ]
then
        echo "## Instalando nueva att"
       cd /tmp/novo/instalador
       ./instalador.sh -d
       ./instalador.sh -i
       echo "### Atualizacion Concluida ! ###"
else
echo "El sistema esta atualizado easy"
fi
sleep 15
done
