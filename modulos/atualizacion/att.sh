#!/bin/bash
rm -rf /tmp/novo
set -o xtrace


#Precose
git clone https://github.com/rhomennik/Apostala /tmp/novo

# Variaveis
MD5=$(md5sum /tmp/novo/apostala2.sh | cut -d " " -f1)
MD5ATUAL=$(md5sum /opt/apostala/apostala2.sh | cut -d " " -f1)
PING=$(ping -c1 google.com &> ping.txt)
PINGG=$(cat ping.txt | cut -d " " -f4)
# =======
# Script=
# =======
echo "ate aqui"
if [ $MD5 != $MD5ATUAL  ]
then
        echo "## Instalando nueva att"
       cd /tmp/novo/instalador
       ./instalador.sh -d
       ./instalador.sh -i
       echo "### Atualizacion Concluida ! ###"
	reboot
else
echo "El sistema esta atualizado easy"
fi

