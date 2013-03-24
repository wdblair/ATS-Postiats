/*
  Sanity check for my ATS approach.
*/

#include <avr/io.h>
#include <avr/interrupt.h>

static struct {
  unsigned int threshold;
  unsigned int ticks;
} t0imer;

ISR(TIMER0_OVF_vect) {

  if(t0imer.ticks == t0imer.threshold) {
    t0imer.ticks = 0;
    
    PORTB ^= _BV(PORTB3);

  } else {
    t0imer.ticks += 1;
  }
}

int main () {
  t0imer.threshold = 61;
  t0imer.ticks = 0;

  TCCR0A &= ~( _BV(WGM01) | _BV(WGM00));
  TCCR0B &= ~_BV(WGM02);
  TCCR0B |= _BV(CS02) | _BV(CS00);

  DDRB |= _BV(DDB3);
  TIMSK0 |= _BV(TOIE0);
  sei();
  while(1);
}
