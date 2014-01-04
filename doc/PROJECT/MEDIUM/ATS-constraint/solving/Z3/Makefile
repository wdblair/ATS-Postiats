#
# A constraint solver based on Z3
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

ifeq ("$(PATSHOME)","")
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="$(PATSHOME)"
endif

ifeq ("$(PATSHOMERELOC)","")
  PATSHOMERELOCQ="$(ATSHOMERELOC)"
else
  PATSHOMERELOCQ="$(PATSHOMERELOC)"
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCC2=\
  $(PATSCC) \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) -IIATS $(PATSHOME)/ccomp/runtime \
  -IIATS $(PATSHOME)/contrib \
  -IIATS ../../ 

######

CFLAGS :=
CFLAGS += -I$(PATSHOMEQ)
CFLAGS += -I$(PATSHOMEQ)/ccomp/runtime
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS := -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)
LDFLAGS += -lz3

######

DATSMEMALLOC=-DATS_MEMALLOC_GCBDW

######

all:: solve-z3

../../constraint.o:
	make -C ../../ constraint.o

../../parsing/parsing.o:
	make -C ../../parsing parsing.o

../solver.o:
	make -C ../ solver.o

solve-z3: main.dats \
	z3.dats \
	z3_dynload.dats \
	../../constraint.o \
	../../parsing/parsing.o \
	../solver.o
	$(PATSCC2) $(CFLAGS)  $^ -o $@ $(DATSMEMALLOC) $(LDFLAGS)

######

RMF=rm -f

######

clean:: ; $(RMF) solve-z3
clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######

