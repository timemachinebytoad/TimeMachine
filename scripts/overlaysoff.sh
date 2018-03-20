#!/bin/bash

#by GPTO for TOAD 2017
#Disables HD content

toaddir="/opt/retropie/configs/all/toad"

clear

echo "Copying configs..."
#configs files

sudo cp -rv $toaddir/scripts/overlaysoff/configs/ /opt/retropie/
sudo rm  /home/pi/RetroPie/roms/mame-libretro/*.cfg

echo "Rebooting..."
sudo reboot

