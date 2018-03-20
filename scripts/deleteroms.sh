echo "Deleting all roms"
cd /home/pi/RetroPie/roms

rm -v amiga/*.adf
rm -v apple2/*.dsk
rm -v atari2600/*
rm -v atari5200/*
rm -v atari7800*
rm -v atari800/*
rm -v atarilynx/*
rm -v atarist/*
rm -v c64/*
rm -v coco/*
rm -v coleco/*
rm -vr daphne/*
rm -v dragon32/*
rm -v dreamcast/*
rm -v fba/*.zip
rm -v fds/*
rm -v gameandwatch/*
rm -v gamegear/*
rm -v gb/*
rm -v gba/*
rm -v gbc/*
rm -v intellivision/*
rm -v mame-advmame/*.zip
rm -v mame-libretro/*.zip
rm -v mame-mame4all/*.zip
rm -v mastersystem/*
rm -v megadrive/*
rm -v msx/*
rm -v n64/*
rm -v nes/*
rm -v ngp/*
rm -v ngpc/*
rm -v oric/*
rm -v pcengine/*
rm -v psx/*
rm -v samcoupe/*
#salvar .sh de scumvm y borrar todo
rm -vr scummvm/*
rm -v sega32x/*
rm -v segacd/*
rm -v sg-1000/*
rm -v snes/*
rm -v vectrex/*
rm -v videopac/*
rm -v wonderswan/*
rm -v wonderswancolor/*
rm -v zxspectrum/*

sudo reboot
