#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: clofuns
clofuns: clofuns.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) clofuns

######

all:: conjdisj
conjdisj: conjdisj.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) conjdisj

######

all:: dotoverld
dotoverld: dotoverld.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) dotoverld

######

all:: extfcall
extfcall: extfcall.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) extfcall

######

all:: fieldarr
fieldarr: fieldarr.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
cleanall:: ; $(RMF) fieldarr

######

all:: findexn
findexn: findexn_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
findexn_dats.c: findexn.dats ; $(PATSCC2) -ccats $<
cleanall:: ; $(RMF) findexn
cleanall:: ; $(RMF) findexn_dats.c

######

all:: fixedpoint
fixedpoint: fixedpoint.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -cleanaft -o $@ $<
cleanall:: ; $(RMF) fixedpoint

######

all:: lazytest
lazytest: lazytest_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
lazytest_dats.c: lazytest.dats ; $(PATSCC2) -ccats $<
cleanall:: ; $(RMF) lazytest
cleanall:: ; $(RMF) lazytest_dats.c
all:: llazytest
llazytest: llazytest_dats.c ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
llazytest_dats.c: llazytest.dats ; $(PATSCC2) -ccats $<
cleanall:: ; $(RMF) llazytest
cleanall:: ; $(RMF) llazytest_dats.c

######

all:: mutailrec
mutailrec: mutailrec.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) mutailrec

######

all:: partmplt
partmplt: partmplt.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) partmplt

######

all:: patguard
patguard: patguard.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patguard

######

all:: patlinrec
patlinrec: patlinrec.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patlinrec

######

all:: patrefas
patrefas: patrefas.dats ; \
  $(PATSCC2) -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) patrefas

######

all:: stkalloc
stkalloc: stkalloc.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) stkalloc

######

all:: sumodd
sumodd: sumodd.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) sumodd

######

all:: trywith
trywith: trywith.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -cleanaft -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) trywith

######

all:: union
union: union.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) union

######

all:: weekday
weekday: weekday.dats ; $(PATSCC2) -cleanaft -o $@ $<
cleanall:: ; $(RMF) weekday

######

###### end of [Makefile] ######