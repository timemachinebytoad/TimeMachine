#echo "Switching to consoles only, please restart EmulationStation"
#dialog --title "WARNING" --msgbox "\n Switching to consoles only\n\n The system will REBOOT now" 8 33

sudo cp  /opt/retropie/configs/all/toad/scripts/es_systems-consoles.cfg /opt/retropie/configs/all/emulationstation/es_systems.cfg
sudo reboot
#sleep 3
