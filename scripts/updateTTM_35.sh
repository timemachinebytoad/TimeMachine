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
wget $URL/TTM_35.zip
unzip -oq TTM_35.zip
rm TTM_35.zip

UPDMSG=`cat msg.txt`
dialog --title "TIME MACHINE by TOAD 3.5.1 update" --msgbox "$UPDMSG" 23 76

#reemplazar Advanced Setup
rm $RDIR/toad/toadsetup.sh
cp -v toadsetup.sh $RDIR/toad/
chown pi:pi $RDIR/toad/toadsetup.sh
chmod +x $RDIR/toad/toadsetup.sh

#reemplazar script deleteroms que fallaba
rm $SDIR/deleteroms.sh 
cp -v deleteroms.sh $SDIR/
chown pi:pi $SDIR/deleteroms.sh
chmod +x $SDIR/deleteroms.sh

#comprobar que existen los gamelist.xml!
mkdir $GDIR/amstradcpc
mkdir $GDIR/c64
mkdir $GDIR/msx
mkdir $GDIR/zxspectrum

if [ ! -f $GDIR/amstradcpc/gamelist.xml ]; then
    cp -v gamelist.xml $GDIR/amstradcpc/
fi

if [ ! -f $GDIR/msx/gamelist.xml ]; then
    cp -v gamelist.xml $GDIR/msx/
fi

if [ ! -f $GDIR/zxspectrum/gamelist.xml ]; then
    cp -v gamelist.xml $GDIR/zxspectrum/
fi

if [ ! -f $GDIR/c64/gamelist.xml ]; then
    cp -v gamelist.xml $GDIR/c64/
fi

#copiar archivos retroworks y commodore plus
cp -v retroworks/amstradcpc/* $RDIR/amstradcpc/
rm $RDIR/amstradcpc/desc.xml
cp -v retroworks/amstradcpc/art/* $CDIR/all/emulationstation/downloaded_images/amstradcpc/

cp -v retroworks/zxspectrum/* $RDIR/zxspectrum/
rm $RDIR/zxspectrum/desc.xml
cp -v retroworks/zxspectrum/art/* $CDIR/all/emulationstation/downloaded_images/zxspectrum/


cp -v retroworks/msx/* $RDIR/msx/
rm $RDIR/msx/desc.xml
mkdir $CDIR/all/emulationstation/downloaded_images/msx/
cp -v retroworks/msx/art/* $CDIR/all/emulationstation/downloaded_images/msx/

cp -v cplus/* $RDIR/c64
rm $RDIR/c64/desc.xml
cp -v cplus/art/* $CDIR/all/emulationstation/downloaded_images/c64/

#añadir descripciones a los gamelist.xml

sed -f retroworks/amstradcpc/desc.xml < $GDIR/amstradcpc/gamelist.xml > gamelist-tmp.xml
mv gamelist-tmp.xml $GDIR/amstradcpc/gamelist.xml
chown pi:pi $GDIR/amstradcpc/gamelist.xml

sed -f retroworks/msx/desc.xml < $GDIR/msx/gamelist.xml > gamelist-tmp.xml
mv gamelist-tmp.xml $GDIR/msx/gamelist.xml
chown pi:pi $GDIR/msx/gamelist.xml

sed -f retroworks/zxspectrum/desc.xml < $GDIR/zxspectrum/gamelist.xml > gamelist-tmp.xml
mv gamelist-tmp.xml $GDIR/zxspectrum/gamelist.xml
chown pi:pi $GDIR/zxspectrum/gamelist.xml

sed -f cplus/desc.xml < $GDIR/c64/gamelist.xml > gamelist-tmp.xml
mv gamelist-tmp.xml $GDIR/c64/gamelist.xml
chown pi:pi $GDIR/c64/gamelist.xml

#copiar juegos de la Enciclopedia Homebrew
cp -rfv enciclopedia/* $RDIR


#copiar config fba sin filtro
cp -v fba/retroarch.cfg $CDIR/fba/
chown pi:pi $CDIR/fba/retroarch.cfg

#reemplazar configs mame, y sus backups (deja solo F1 para menu)
sudo cp -v mame-default.cfg $CDIR/mame-mame4all/cfg/default.cfg
sudo cp -v mame2003-default.cfg $RDIR/mame-libretro/mame2003/cfg/default.cfg

sudo cp -v mame-default.cfg $SDIR/
sudo cp -v mame2003-default.cfg $SDIR/

#poner megadrive en modo 6 botones
sed -i "/^picodrive_input1 = \"3 button pad\"/c\picodrive_input1 = \"6 button pad\"" $CDIR/all/retroarch-core-options.cfg
sed -i "/^picodrive_input2 = \"3 button pad\"/c\picodrive_input2 = \"6 button pad\"" $CDIR/all/retroarch-core-options.cfg
#sed -i '$ a picodrive_input1 = "6 button pad"\npicodrive_input2 = "6 button pad"' $CDIR/all/retroarch-core-options.cfg


#poner mas brillo a Amstrad
sed -i "/^cap32_scr_intensity = \"5\"/c\cap32_scr_intensity = \"15\"" $CDIR/all/retroarch-core-options.cfg

#limpieza
rm /home/pi/audio001.wav
rm -vr /home/pi/RetroPie/BIOS/temp
rm -rf ~/.local/share/Trash/files/

cd $SDIR
echo "TTM_351" > ttm.version
chown pi:pi ttm.version

#if [ ! -d /opt/retropie/configs/all/toad ]; then
#    mkdir /opt/retropie/configs/all/toad
#    cd /opt/retropie/configs/all/toad
#    cp -r /home/pi/scripts/* .
#fi

sudo reboot now
