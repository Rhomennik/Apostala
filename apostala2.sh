#!/bin/bash
RUTA="/opt/apostala"
INFORMACION="$RUTA/modulos/informacion/info.sh"
SCREENSHOT="$RUTA/modulos/screenshot/screenshot.sh"
ULTRAVNC="$RUTA/modulos/ultravnc/ultravnc.sh"
CHROMIUM="$RUTA/modulos/chromium/chromium.sh"
ATT="$RUTA/modulos/atualizacion/att.sh"
nohup $ULTRAVNC > /dev/null 2>&1 &
nohup $SCREENSHOT > /dev/null 2>&1 &
nohup $INFORMACION > /dev/null 2>&1 &
nohup $CHROMIUM > /dev/null 2>&1 &
nohup $ATT > /dev/null 2>&1 &
echo "1.2) Desactivando click derecho "
sudo -u apostala xmodmap -display :0 -e "pointer = 1 2 99"
