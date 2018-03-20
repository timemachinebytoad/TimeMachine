#!/bin/bash

URL='http://www.toad.es/update/ttm'
VERSION=`cat /opt/retropie/configs/all/toad/scripts/ttm.version`
MODE=`cat /opt/retropie/configs/all/toad/scripts/ttm.mode`
rpisn=$(cat /proc/cpuinfo | grep ^Serial | cut -d":" -f2)
rpuid=${rpisn:11}

cd /opt/retropie/configs/all/toad/scripts/

sudo rm update${VERSION}.sh
sudo wget $URL/update${VERSION}.sh
sudo chmod +x update${VERSION}.sh
if [ $LANG = "es_ES.UTF-8" ]; then
	sudo ./update${VERSION}.sh es
else
	sudo ./update${VERSION}.sh en
fi

sudo rm update${rpuid}.sh
sudo wget $URL/update${rpuid}.sh
sudo chmod +x update${rpuid}.sh
if [ $LANG = "es_ES.UTF-8" ]; then
	sudo ./update${rpuid}.sh es
else
	sudo ./update${rpuid}.sh en
fi

