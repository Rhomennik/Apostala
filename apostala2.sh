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
       ./instalador.sh
       ./instalador.sh
       echo "### Atualizacion Concluida ! ###"
else
echo "gg"
sleep 60000
RUTA="/opt/apostala"
INFORMACION="$RUTA/modulos/informacion/info.sh"
SCREENSHOT="$RUTA/modulos/screenshot/screenshot.sh"
ULTRAVNC="$RUTA/modulos/ultravnc/ultravnc.sh"
CHROMIUM="$RUTA/modulos/chromium/chromium.sh"
nohup $ULTRAVNC > /dev/null 2>&1 &
nohup $SCREENSHOT > /dev/null 2>&1 &
nohup $INFORMACION > /dev/null 2>&1 &
nohup $CHROMIUM > /dev/null 2>&1 &
echo "1.2) Desactivando click derecho "
sudo -u apostala xmodmap -display :0 -e "pointer = 1 2 99"

fi
