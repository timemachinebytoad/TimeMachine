echo "Restoring all systems configurations to original settings..."

sudo cp -rv /opt/retropie/configs/all/toad/scripts/configs /opt/retropie/

sudo cp /opt/retropie/configs/all/toad/scripts/mame-default.cfg /opt/retropie/configs/mame-mame4all/cfg/default.cfg
sudo cp /opt/retropie/configs/all/toad/scripts/mame2003-default.cfg /home/pi/RetroPie/roms/mame-libretro/mame2003/cfg/default.cfg



#sudo cp /opt/retropie/configs/all/toad/scripts/advmame-0.94.0.rc /opt/retropie/configs/mame-advmame/
#sleep 3
