MCU=atmega328p
F_CPU=16000000UL
all: timer

AVRPATH= $(PATSHOME)/contrib/avr

timer: timer_dats.c
	avr-gcc -D_ATS_CCOMP_RUNTIME_NONE -std=c99 -DF_CPU=$(F_CPU) -Os -mmcu=$(MCU)  -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime \
	-I $(AVRPATH) -L $(AVRPATH)/lib -L $(AVRPATH)/lib/$(MCU) -o $@ $< -l$(MCU)
	avr-size $@
	avr-objcopy -O ihex $@ ~/Dropbox/$@.hex

typecheck: timer.dats
	patsopt-z3 -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

timer_dats.c: timer.dats
	patsopt-z3 -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c timer
