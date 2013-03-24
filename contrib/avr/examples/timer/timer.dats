staload "SATS/io.sats"
staload "SATS/timer.sats"
staload "SATS/interrupt.sats"

staload "prelude/DATS/integer.dats"

staload "DATS/timer.dats"
staload "DATS/atomic.dats"

staload "DATS/atmega328p/io.dats"
staload "DATS/atmega328p/timer.dats"

#define ATS_DYNLOADFLAG 0

stadef m = atmega328p

implement delayed_task_work<timer0><m>(pf | (**)) = false where {
  val () = flipbits(PORTB<m>(), PORTB3)
}

implement TIMER0_OVF_vect(pf | ) = timer_overflow<timer0><m>(pf | )

extern
fun main_interrupts (pf: !INT_CLEAR | (**)): int = "main"

implement main_interrupts (pf | ) = 0 where {
  val () = setbits(DDRB<m>(), DDB3)
  val () = delayed_task<timer0><m>(10ul)
  
  val (on | ()) = sei(pf | (**))
  val () = while (true)()
  val (locked | ()) = cli(on | (**))
  prval () = pf := locked
}