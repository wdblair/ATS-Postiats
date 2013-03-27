#ifndef _AVR_LIBATS_USART_HEADER
#define _AVR_LIBATS_USART_HEADER

#include <stdlib.h>


ATSinline()
atstype_uint
avr_libats_ubrr_of_baud (atstype_uint baud) {
  //ubrr = ( F_CPU / (BAUD x 16 ) ) - 1
  unsigned int ubrr;
  ldiv_t div;
  div = ldiv((F_CPU >> 4), baud);
  ubrr = (unsigned int)div.quot;
  
  if((uint32_t)(div.rem) < baud)
    ubrr--;
  return ubrr;
}

#endif
