system=$1
emul=$2
rom=$3
title=""
rom_bn="${rom##*/}"
echo "$rom_bn" > /dump.xt
GAMELIST="/opt/retropie/configs/all/emulationstation/gamelists/${system}/gamelist.xml"
#title=`grep -A1 "${rom_bn}" ${GAMELIST} | awk '{getline;print}'  `
#| awk 'BEGIN {FS="<name>"} {print $2}' | awk 'BEGIN {FS="</name>"} {print $1}'`

title=`xmllint --xpath "gameList/game[path/text()='./${rom_bn}']/name/text()" $GAMELIST `

#echo "$title" > /dump.txt
sudo python /opt/retropie/configs/all/toad/lcd/lcdlogos.py $system "$title"
