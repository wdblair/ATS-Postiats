MCU=atmega328p
F_CPU=16000000UL
all: usart

AVRPATH= $(PATSHOME)/contrib/avr

usart: usart_dats.c
	avr-gcc -DF_CPU=$(F_CPU) -mmcu=$(MCU) -Os -I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime \
	-I $(AVRPATH) -L $(AVRPATH)/lib -L $(AVRPATH)/lib/$(MCU) -o $@ $< -l$(MCU)
	avr-size $@
	avr-objcopy -O ihex $@ ~/Dropbox/$@.hex

typecheck: usart.dats
	patsopt -DATS_MCU=$(MCU) -IATS $(PATSHOME)/contrib/avr --typecheck --dynamic $<

usart_dats.c: usart.dats
	patsopt -IATS $(PATSHOME)/contrib/avr -DATS MCU=$(MCU) --output $@ --dynamic $<

.phony: clean

clean:
	rm *.c usart
