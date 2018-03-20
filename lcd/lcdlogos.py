#Shows emulator logos in LCD - based on Tony Dicola's drivers
#by GPTO for TOAD - 2018

import time, sys , socket , os

import Adafruit_Nokia_LCD as LCD
import Adafruit_GPIO.SPI as SPI

from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont


# Raspberry Pi hardware SPI config:
DC = 23
RST = 24
SPI_PORT = 0
SPI_DEVICE = 0

# Hardware SPI usage:
disp = LCD.PCD8544(DC, RST, spi=SPI.SpiDev(SPI_PORT, SPI_DEVICE, max_speed_hz=4000000))

# Initialize library.
disp.begin(contrast=65)

# Clear display.
disp.clear()
disp.display()



# Load image and convert to 1 bit color.
logo = '/opt/retropie/configs/all/toad/lcd/logos/' + sys.argv[1] + '.bmp'
image = Image.open(logo).convert('1')

#text Y position for rom name
ty = 0
tx = 17
if sys.argv[2] :

	draw = ImageDraw.Draw(image)
	font = ImageFont.truetype('/opt/retropie/configs/all/toad/lcd/6px2bus.ttf', 6)
	draw.rectangle((tx-1,ty,83,ty+5), fill=1)
#	draw.line((tx,ty,83,ty), fill=0)
#	draw.line((tx,ty+10,83,ty+10), fill=0)
	draw.text((tx,ty), sys.argv[2] , font=font)

if sys.argv[1] == 'logottm':

	draw = ImageDraw.Draw(image)
	font = ImageFont.truetype('/opt/retropie/configs/all/toad/lcd/Minecraftia-Regular.ttf', 8)
	#font = ImageFont.load_default()
	
	#Display my IP
	try:
		myip= [l for l in ([ip for ip in socket.gethostbyname_ex(socket.gethostname())[2] if not ip.startswith("127.")][:1], [[(s.connect(('8.8.8.8', 80)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]]) if l][0][0]
	except socket.error:
		myip= "       www.toad.es"
	#myip= '190.160.200.200'

	draw.text((0,34), '{:^14}'.format(myip) , font=font)
	draw.line((1,44,82,44), fill=0)
	draw.line((1,47,82,47), fill=0)
	draw.line((0,45,0,46), fill=0)
	draw.line((83,45,83,46), fill=0)

	#Displays disk space
	st = os.statvfs('/')
	free = st.f_bavail * st.f_frsize
	total = st.f_blocks * st.f_frsize
	used = (st.f_blocks - st.f_bfree) * st.f_frsize
	usedline = (used * 82) / total
	draw.rectangle((1,45,usedline,46), outline=0, fill=0)



# Display image.
disp.image(image)
disp.display()


