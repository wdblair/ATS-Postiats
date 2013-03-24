#ifndef _AVR_LIBATS_TIMER_HEADER
#define _AVR_LIBATS_TIMER_HEADER

typedef struct {
  unsigned int threshold;
  unsigned int ticks;
} hardware_timer_t;

extern
hardware_timer_t t0imer;

extern
hardware_timer_t t1imer;

extern
hardware_timer_t t2imer;



#endif
