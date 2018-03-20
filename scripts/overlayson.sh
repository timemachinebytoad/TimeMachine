#!/bin/bash

#by GPTO for TOAD 2017
#Enables HD content

toaddir="/opt/retropie/configs/all/toad"

clear

echo "Copying configs..."
#configs files

sudo cp -rv $toaddir/scripts/overlayson/configs/ /opt/retropie/
sudo cp -rv $toaddir/scripts/overlayson/mame-libretro/ /home/pi/RetroPie/roms/
echo "Rebooting..."
sudo reboot

