#!/bin/bash
URL='http://www.toad.es/update/ttm'
SDIR='/opt/retropie/configs/all/toad/scripts'
CDIR='/opt/retropie/configs'
RDIR='/home/pi/RetroPie/roms'
GDIR='/opt/retropie/configs/all/emulationstation/gamelists'
VERSION=`cat /opt/retropie/configs/all/toad/scripts/ttm.version`
MODE=`cat /opt/retropie/configs/all/toad/scripts/ttm.mode`

rpisn=$(cat /proc/cpuinfo | grep ^Serial | cut -d":" -f2)
rpuid=${rpisn:11}

cd /tmp

rm -rf *
wget $URL/TTM_351.zip
unzip -oq TTM_351.zip
rm TTM_351.zip

UPDMSG=`cat msg.txt`
dialog --title "TIME MACHINE by TOAD 3.5.2 update" --msgbox "$UPDMSG" 25 76

#reemplazar scripts Advanced Setup y Switch
rm $RDIR/toad/toadsetup.sh
cp -v toadsetup.sh $RDIR/toad/
chown pi:pi $RDIR/toad/toadsetup.sh
chmod +x $RDIR/toad/toadsetup.sh

rm $SDIR/ttmswitch.sh
cp -v ttmswitch.sh $SDIR/
chown pi:pi $SDIR/ttmswitch.sh
chmod +x $SDIR/ttmswitch.sh


#reemplazar configs mame, y sus backups (deja solo F1 para menu)
#sudo cp -v mame-default.cfg $CDIR/mame-mame4all/cfg/default.cfg
#sudo cp -v mame2003-default.cfg $RDIR/mame-libretro/mame2003/cfg/default.cfg

sudo cp -v mame-default.cfg $SDIR/
sudo cp -v mame2003-default.cfg $SDIR/

sudo cp -v mame-default.cfg $SDIR/configs/all/toad/scripts/
sudo cp -v mame2003-default.cfg $SDIR/configs/all/toad/scripts/

sudo cp -v runcommand.cfg $SDIR/configs/all/


#instalar juegos de GameMaker y configurar ES con contenidos
echo -e "\n\nDownloading and installing Game maker games...\n\n"
wget -O- -q https://www.yoyogames.com/download/pi/castilla | tar -xvz -C /home/pi/RetroPie/roms/ports/
wget -O- -q https://www.yoyogames.com/download/pi/tntbf | tar -xvz -C /home/pi/RetroPie/roms/ports/
wget -O- -q https://www.yoyogames.com/download/pi/crate | tar -xvz -C /home/pi/RetroPie/roms/ports/

sudo mv -fv ports/*.png $CDIR/all/emulationstation/downloaded_images/ports/

sudo mv -fv ports/gamelist.xml $GDIR/ports/
chown pi:pi $GDIR/ports/gamelist.xml

sudo mv -fv ports/*.sh $RDIR/ports/

#meter datos scrapeo a mame4all
echo -e "\n\nAdding scraper data to mame4all...\n\n"
sudo mv -fv mame-mame4all/gamelist.xml $GDIR/mame-mame4all/
chown pi:pi $GDIR/mame-mame4all/gamelist.xml
sudo mv -fv mame-mame4all $CDIR/all/emulationstation/downloaded_images/

#copiar carpetas de arcade , kb y nueva lcd
sudo mv -fv arcade $CDIR/all/toad/
rm -rf $CDIR/all/toad/lcd
sudo mv -fv lcd $CDIR/all/toad/

if [[ $MODE == "kb" ]]
then
  sudo cp -v runcommand-onstart.sh /opt/retropie/configs/all/
  sudo cp -v runcommand-onend.sh /opt/retropie/configs/all/
  sudo cp -v rc.local /etc/
fi

sudo cp -v runcommand-onstart.sh /opt/retropie/configs/all/toad/kb/configs/all
sudo cp -v runcommand-onend.sh /opt/retropie/configs/all/toad/kb/configs/all
sudo cp -v rc.local /opt/retropie/configs/all/toad/kb/
sudo cp -v logottm.bmp $CDIR/all/toad/kb/


sudo apt-get update
echo -e "\n\nInstalling XML tools... Be patient...\n\n"
sudo apt-get install libxml2-utils

#reemplazar splashscreens por nuevas
sudo cp -v ttmv3.png $CDIR/all/toad/v3/
sudo cp -v ttmkb.png $CDIR/all/toad/kb/
sudo cp -v ttmmini.png $CDIR/all/toad/mini/
sudo cp -v ttmlite.png $CDIR/all/toad/lite/
sudo cp -v ttm$MODE.png /home/pi/Pictures/ttm.png

#juegos homebrew de n64 y wonderswan
sudo cp -v homebrew/*.nds $RDIR/nds/
sudo cp -v homebrew/*.wsc $RDIR/wonderswancolor/
sudo cp -v homebrew/*.v64 $RDIR/n64/

cd $SDIR
echo "TTM_352" > ttm.version
chown pi:pi ttm.version

history -c
rm /home/pi/.config/filezilla/recentservers.xml

sudo reboot now
