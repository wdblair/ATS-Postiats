MCU=atmega328p
F_CPU=16000000UL
all: fast phase-correct

AVRPATH= $(PATSHOME)/contrib/avr

fast: fast_dats.c
	avr-gcc -D_ATS_CCOMP_RUNTIME_NONE -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -L $(AVRPATH)/lib -o $@ $<
	avr-size $@
	sudo avr-objcopy -O ihex $@ /mnt/shared/$@.hex

phase-correct: phase-correct_dats.c
	avr-gcc -D_ATS_CCOMP_RUNTIME_NONE -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime -I $(AVRPATH) -L $(AVRPATH)/lib -o $@ $<
	avr-size $@
	sudo avr-objcopy -O ihex $@ /mnt/shared/$@.hex

%_dats.c: %.dats
	patsopt -IATS $(PATSHOME)/contrib/avr --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c fast phase-correct
