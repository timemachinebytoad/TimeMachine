#!/bin/bash

#by GPTO for TOAD 2018

clear
rootdir="/opt/retropie"
toaddir="/opt/retropie/configs/all/toad"
toadupd="http://www.toad.es/www/update/ttm"

    rpisn=$(cat /proc/cpuinfo | grep ^Serial | cut -d":" -f2)
    rpuid=${rpisn:11}
    ip_int=$(ip route get 8.8.8.8 2>/dev/null | head -1 | cut -d' ' -f8)
    /opt/retropie/supplementary/runcommand/joy2key.py /dev/input/js0 kcub1 kcuf1 kcuu1 kcud1 0x0a 0x09 &
    JOY2KEY_PID=$!
    
while true; do 
   cmd=(dialog --backtitle "Time Machine by TOAD 2018" --title "Configuration Menu" --cancel-label "Exit" --item-help --default-item "$default" --menu "Version: 3.5.2\nCurrent IP: $ip_int\nRaspberry UID: $rpuid" 20 76 16)

    options=(
            R "Restore all configurations"
                 "R This will set all systems to default settings"
            
            D "Disable HD overlays"
                "D Use this option if you don't have a 1080p screen"
            
            E "Enable HD overlays"
                "E By default this option is active"                
            
            K "Switch to KB mode (Internet required)"
                "K Changes the software to work in a Time Machine KB (Internet required)"

            M "Switch to Mini mode"
                "M Changes the software to work in a Time Machine Mini"

            L "Switch to Lite mode"
                "L Changes the software to work in a Time Machine Lite"

            A "Switch to Arcade mode (Internet required)"
                "L Changes the software to work in a Time Machine Arcade (Internet required)"
                
            V "Switch to V3 mode"
                "V Changes the software to work in a Time Machine V3"
        
            U "Check for updates"
                "U Downloads the last version of this software. Internet is required."

            I "Delete all roms"
                "D Delete all roms installed"
             
        )

        choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break

        case "$choice" in
            K)
                exec "$toaddir/scripts/ttmswitch.sh" kb
                ;;
            M)
                exec "$toaddir/scripts/ttmswitch.sh" mini
                ;;
            L)
                exec "$toaddir/scripts/ttmswitch.sh" lite
                ;;
            V)
                exec "$toaddir/scripts/ttmswitch.sh" v3
                ;;
            A)
                exec "$toaddir/scripts/ttmswitch.sh" arcade
                ;;
            U)
                exec "$toaddir/scripts/ttmupdate.sh" 
                ;;           
            I)
                dialog --defaultno --yesno "This will delete all roms!!!.\nAre you sure?" 8 45 2>&1 >/dev/tty || continue        
                exec "$toaddir/scripts/deleteroms.sh"
                ;;
            D)
                dialog --defaultno --yesno "Removing HD content.\nThe system will reboot.\nAre you sure?" 8 45 2>&1 >/dev/tty || continue        
                exec "$toaddir/scripts/overlaysoff.sh"
                ;;
            E)
                dialog --defaultno --yesno "Installing HD content.\nThe system will reboot.\nAre you sure?" 8 45 2>&1 >/dev/tty || continue        
                exec "$toaddir/scripts/overlayson.sh"
                ;;                
            R)
                dialog --defaultno --yesno "This will change all emulator settings to default.\nAre you sure?" 7 45 2>&1 >/dev/tty || continue                
                exec "$toaddir/scripts/restoreconfigs.sh"
                ;;
             esac
done

kill -INT "$JOY2KEY_PID"
    
clear



