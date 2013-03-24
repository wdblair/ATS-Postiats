all:: libatmega328p.a

sources = t0imer.c t1imer.c t2imer.c
objects = t0imer.o t1imer.o t2imer.o
 
libatmega328p.a: $(objects)
	ar rcs $@ $^

%.o: %.c
	avr-gcc -c -mmcu=atmega328p -I ../../ -o $@ $<

.phony: clean

clean:
	rm libatmega328p.a *.o