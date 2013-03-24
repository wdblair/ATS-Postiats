staload "SATS/timer.sats"
staload "SATS/atomic.sats"

staload "prelude/DATS/integer.dats"

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

implement {timer} {mcu} timer_overflow(atomic | (* *)) = {
    val (pf | time) = get_timer<timer><mcu>(atomic | (**))
    val () = time->ticks :=
      (time->ticks + 1u) mod time->threshold
    val _ = if time->ticks = 0u then {
        val _ = delayed_task_work<timer><mcu>(atomic | (**))
    }
    prval () = return_timer(atomic, pf)
}