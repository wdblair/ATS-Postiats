MCU=atmega328p
F_CPU=16000000UL
all: pwm

AVRPATH= $(PATSHOME)/contrib/avr

pwm: pwm_dats.c
	avr-gcc -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -L $(AVRPATH)/lib -o $@ $< -lats
	avr-size $@
	avr-objcopy -O ihex $@ ~/Dropbox/$@.hex

typecheck: pwm.dats
	patsopt -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

pwm_dats.c: pwm.dats
	patsopt -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c pwm
