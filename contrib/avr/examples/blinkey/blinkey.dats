staload "SATS/main.sats"
staload "SATS/io.sats"

staload "DATS/iom328p.dats"

//This should be automatically included from io.sats
%{^
#include "CATS/io.cats"
%}

stadef m = atmega328p

#define ATS_DYNLOADFLAG 0

implement setup() = {
  val _ = setbits(DDRB<m>(), DDB3)
}

implement event () = ()

