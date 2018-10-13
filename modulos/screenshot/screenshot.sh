#!/bin/bash



# Variables

INTERFACE=$(/sbin/route -n | grep '^0\.0\.0\.0' | head -n 1 | awk '{print $NF}')
MAC_ADREESS=$(/sbin/ifconfig $INTERFACE | sed -n '4 p' | awk '{print $2}')
FOTO=$(echo $MAC_ADREESS | sed 's/://g')
#while :; do
while [ true ]
do
echo 'sleep 1; DISPLAY=:0 XAUTHORITY=/var/run/lightdm/root/$DISPLAY xwd -root' > /tmp/$FOTO.sh
bash /tmp/$FOTO.sh >/tmp/$FOTO.xwd
convert /tmp/$FOTO.xwd -resize 178x180 -strip -quality 50 -interlace line /tmp/$FOTO.jpg
convert /tmp/$FOTO.xwd  /tmp/$FOTO-original.jpg
sleep 5
done

