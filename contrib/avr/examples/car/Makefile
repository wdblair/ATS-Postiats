MCU=atmega328p
F_CPU=16000000UL
all: car

AVRPATH= $(PATSHOME)/contrib/avr

PATSOPT=patsopt

car: car_dats.c
	avr-gcc -D_ATS_CCOMP_RUNTIME_NONE -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -o $@ $<
	avr-size $@
	sudo avr-objcopy -O ihex $@ /mnt/shared/$@.hex

typecheck: car.dats
	$(PATSOPT) -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

car_dats.c: car.dats
	$(PATSOPT) -DATS_ATS_CCOMP_RUNTIME_NONE -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c car
