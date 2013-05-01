all: example

PATSOPT=patsopt

example_dats.c: example.dats
	patsopt -IATS $(PATSHOME) --output $@ --dynamic $<

example: example_dats.c
	gcc -std=c99 -O2 -I $(PATSHOME)/contrib/SMT -I $(PATSHOME)/ccomp/runtime -I $(PATSHOME) $^ -o $@ -lz3

.phony: clean

clean:
	rm *_dats.c example