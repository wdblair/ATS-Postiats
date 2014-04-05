/*
Part2:
Please see:
https://singpolyma.net/2012/01/writing-a-simple-os-kernel-user-mode/
*/

/* ****** ****** */

#include "versatilepb.h"

/* ****** ****** */

void bwputs(char *string)
{
  char c;
  while((c = *string)) {
    while(*(UART0 + UARTFR) & UARTFR_TXFF); *UART0 = c; string++;
  } /* end of [while] */
  return ;
}

/* ****** ****** */

int main(void) {
  bwputs("Starting\n");

  while(1); /* We can't exit, there's nowhere to go */
  return 0;
}

/* ****** ****** */

/* end of [kernel.c] */