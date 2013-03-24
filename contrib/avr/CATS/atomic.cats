#ifndef _AVR_LIBATS_ATOMIC_HEADER
#define _AVR_LIBATS_ATOMIC_HEADER


#define atomic_cli(sreg) cli()
#define atomic_restore_sreg(sreg)  \
  do {                             \
  __asm volatile ("":::"memory");  \
  SREG = sreg;                     \
  } while(0)

#define save_sreg() SREG

#endif
