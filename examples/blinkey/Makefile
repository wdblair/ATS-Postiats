MCU=atmega328p

all: blinkey

AVRPATH= $(PATSHOME)/contrib/avr

blinkey: blinkey_dats.c
	avr-gcc -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -L $(AVRPATH)/lib -o $@ $< -lats
	avr-size $@
	avr-objcopy -O ihex $@ ~/Dropbox/$@.hex

typecheck: blinkey.dats
	patsopt -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

blinkey_dats.c: blinkey.dats
	patsopt -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c blinkey
