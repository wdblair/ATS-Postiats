# Postiats doesn't compile loops or optimize for tail recursion yet,
# so we delegate the main loop to C. The simple library gives the main
# function.

all: libats.a

libats.a: main.o
	ar rcs $@ $^

main.o: main.c
	avr-gcc -c main.c

.phony: clean

clean:
	rm *.o *.a
