all:
	cat base.s loadFullChar.s interrupt.s vblank.s clearScreen.s > combined.s
	php tools/convertBitmapToCharMap.php -t fsbat -f assets/batmanFullscreen.raw >> combined.s
	php tools/convertBitmapToCharMap.php -t batzoom1 -f assets/batmanZoom1.raw >> combined.s
	php tools/8to4bitAudioConvert.php -f assets/imbatman.raw -t imbatman >> combined.s
	mac2c64 -r combined.s
	tools/exomizer sfx 0x0C01 combined.rw -o imbatman.prg
	tools/createLabels.sh combined.s
