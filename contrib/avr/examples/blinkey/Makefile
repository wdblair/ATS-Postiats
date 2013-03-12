MCU=atmega328p
F_CPU=16000000UL
all: blinkey

AVRPATH= $(PATSHOME)/contrib/avr

PATSOPT=patsopt-z3

blinkey: blinkey_dats.c
	avr-gcc -D_ATS_CCOMP_RUNTIME_NONE -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -o $@ $<
	avr-size $@
	avr-objcopy -O ihex $@ ~/Dropbox/$@.hex

typecheck: blinkey.dats
	$(PATSOPT) -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

blinkey_dats.c: blinkey.dats
	$(PATSOPT) -DATS_ATS_CCOMP_RUNTIME_NONE -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c blinkey
