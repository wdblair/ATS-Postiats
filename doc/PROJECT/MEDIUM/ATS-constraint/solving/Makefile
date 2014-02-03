#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

PATSCC := $(PATSCC) -IATS ../

######

CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L$(PATSHOMEQ)/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)

######

all:: solving.o

######

SOURCES_SATS += \
  solver.sats \
  smt.sats \
  smt_ML.sats \
  error.sats

SOURCES_DATS += \
  solver.dats \
  error.dats \
  solver_smt.dats \
  solver_s2cstmap.dats \
  solver_dynload.dats

######

MYTARGET=MYTARGET

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS :=
OBJECTS += $(MYTARGET_SATS_O)
OBJECTS += $(MYTARGET_DATS_O)

######

solving.o: $(OBJECTS) ; ld -r -o $@ $^

######

cleanall:: ; $(RMF) solver.o

###### end of [Makefile] ######
