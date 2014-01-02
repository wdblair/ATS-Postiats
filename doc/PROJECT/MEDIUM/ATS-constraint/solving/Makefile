#
# A simple Makefile
#
# TODO: put together a template for this project

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
  -IIATS ../	\
  -IIATS $(PATSHOME) -IIATS $(PATSHOME)/ccomp/runtime

######

all:: solver.o

######

solver.o: \
  solver_sats.o \
  smt_sats.o    \
  solver_dats.o \
  error_sats.o  \
  error_dats.o  \
  solver_smt_dats.o \
  dynloadall_dats.o ; ld -r -o $@ $^

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

%_sats.o: %.sats ; $(PATSCC) -IIATS ../ -c $<

%_dats.o: %_dats.c ; $(PATSCC2) $(DATSMEMALLOC) -c $<
%_dats.c: %.dats solver.sats ; $(PATSCC2) -ccats $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) solver.o

###### end of [Makefile] ######
