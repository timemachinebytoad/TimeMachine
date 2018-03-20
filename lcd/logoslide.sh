#bin/sh
folder="/home/pi/RetroPie/BIOS/lcd/logos/*"

for logofile in $folder
do
	fnt=${logofile%.*}
	fn=${fnt##*/}
	#echo $fn
	logodisplay=$(sudo python /home/pi/RetroPie/BIOS/lcd/lcdlogos.py $fn)
	eval $logodisplay
done

