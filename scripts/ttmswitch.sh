#!/bin/bash

#by GPTO for TOAD 2017
#It changes TTM mode based on a parameter (v3,mini,kb...)

toaddir="/opt/retropie/configs/all/toad"
configs="/opt/retropie/configs"

clear
echo "Switching to $1 mode..."

echo "$1" > $toaddir/scripts/ttm.mode

#splashscreen
sudo cp $toaddir/$1/ttm$1.png /home/pi/Pictures/ttm.png

#mame files
sudo cp $toaddir/$1/mame-default.cfg $configs/all/toad/scripts/mame-default.cfg 
sudo cp $toaddir/$1/mame2003-default.cfg $configs/all/toad/scripts/mame2003-default.cfg
#sudo cp $toaddir/$1/advmame-0.94.0.rc $configs/all/toad/scripts/advmame-0.94.0.rc
sudo cp $configs/all/toad/scripts/mame-default.cfg /opt/retropie/configs/mame-mame4all/cfg/default.cfg
sudo cp $configs/all/toad/scripts/mame2003-default.cfg /home/pi/RetroPie/roms/mame-libretro/mame2003/cfg/default.cfg
#sudo cp $configs/all/toad/scripts/advmame-0.94.0.rc /opt/retropie/configs/mame-advmame/

#GPIO files
sudo cp $toaddir/$1/config.txt /boot/
sudo cp $toaddir/$1/rc.local /etc/
sudo cp $toaddir/$1/retrogame.cfg $toaddir/scripts/
sudo cp $toaddir/$1/modules /etc/

echo "Copying configs..."
#configs files
sudo rm -f $configs/all/runcommand-onstart.sh
sudo rm -f $configs/all/runcommand-onend.sh
sudo cp -rv $toaddir/$1/configs/ /opt/retropie/

#ES scripts
#sudo cp $toaddir/$1/retroarch.sh /opt/retropie/supplementary/emulationstation/scripts/configscripts/
#sudo cp $toaddir/$1/reicast.sh /opt/retropie/emulators/reicast/bin/

if [[ "$1" == "kb" ]]
then
  cd /home/pi/Adafruit_Nokia_LCD
  sudo python setup.py install
  sudo raspi-config --expand-rootfs
  exec "/home/pi/RetroPie/roms/toad/showcomputers.sh"
else
  exec "/home/pi/RetroPie/roms/toad/showall.sh"
fi


echo "Rebooting..."
sudo reboot

