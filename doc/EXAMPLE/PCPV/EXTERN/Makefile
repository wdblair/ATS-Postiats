PATSOPT= patsopt

all: test

.phony: cleanall

.phony: clean

clean:
	rm -f *_dats.c *_dats.o

cleanall:: clean


test:: list

list: list.dats list.smt2
	$(PATSOPT) --constraint-export -tc -d $< | patsolve list.smt2

test:: list_vt

list_vt: list_vt.dats list.smt2
	$(PATSOPT) --constraint-export -tc -d $< | patsolve list.smt2

test:: array

array: array.dats array.smt2
	$(PATSOPT) --constraint-export -tc -d $< | patsolve array.smt2

test :: list_insort

list_insort: list_insort.dats list_insort.smt2
	$(PATSOPT) --constraint-export -tc -d $< | patsolve list_insort.smt2

build:: list_insort

#TODO: Refactor to make this a little more clean
list_insort_build: list_insort.dats list_insort.smt2 list_insort
        # uncomment assumes in the code, they can mess up type \
	checking for these examples
	sed 's/\/\/ assume/assume/g' $< | $(PATSOPT) --constraint-ignore -o list_insort_dats.c -d
	$(CC) -std=c99 -D_XOPEN_SOURCE -DATS_MEMALLOC_LIBC \
	-I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime \
	-I $(PATSHOME) list_insort_dats.c -o list_insort

build:: quicksort_build

quicksort_build: quicksort.dats quicksort.smt2 quicksort
	sed 's/\/\/ assume/assume/g' $< | $(PATSOPT) --constraint-ignore -o quicksort_dats.c -d
	$(CC) -c -std=c99 -D_XOPEN_SOURCE -DATS_MEMALLOC_LIBC \
	-I $(PATSHOME) -I $(PATSHOME)/ccomp/runtime \
	-I $(PATSHOME) quicksort_dats.c -o quicksort.o

build:: qsort

qsort: quicksort_build main.c
	gcc -D_XOPEN_SOURCE -std=c99 main.c quicksort.o -o $@

cleanall::
	rm -f list_insort qsort *.o *_dats.c

test :: quicksort

quicksort: quicksort.dats quicksort.smt2
	$(PATSOPT) --constraint-export -tc -d $< | patsolve quicksort.smt2
