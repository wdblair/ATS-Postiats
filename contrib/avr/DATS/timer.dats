staload "SATS/io.sats"

staload "SATS/timer.sats"
staload "SATS/atomic.sats"

staload "SATS/delay.sats"

staload "prelude/DATS/integer.dats"

staload "DATS/atmega328p/io.dats"

typedef Uint = [p:pos] uint p

implement {timer} {mcu} delayed_task{p}(period) = {
  //
  implement atomic_section<Uint>(atomic | period) = {
    val (pf | p) = get_timer<timer><mcu>(atomic | (**))
    val () = delayed_task_configure_timer<timer><mcu>(!p, period)
    prval () = return_timer(atomic, pf)
  }
  //
  val () = atomic<Uint>(period)
}

extern
castfn uint_of_uint8 (_: uint8): [n:nat] uint n

implement {timer} {mcu} timer_overflow(atomic | (* *)) = let
    val (pf | time) = get_timer<timer><mcu>(atomic | (**))
    val tic = !time.ticks
in
  if tic = !time.threshold then {
    val () = !time.ticks := 0u
    val _ = delayed_task_work<timer><mcu>(atomic | (**))
    prval () = return_timer(atomic, pf)
  }
  else {
    val () = !time.ticks := tic + 1u
    prval () = return_timer(atomic, pf)
  }
end