staload "SATS/timer.sats"
staload "SATS/atomic.sats"

implement {timer} {mcu} delayed_task(period) = {
  //
  implement atomic_section<ulint>(atomic | period)= {
    val (pf | p) = get_timer<timer><mcu>(atomic | (**))
    val () = delayed_task_configure_timer<timer><mcu>(!p, period)
    prval () = return_timer(atomic, pf)
  }
  //
  val () = atomic<ulint>(period)
}

implement {timer} {mcu} timer_overflow(atomic | (* *)) = {
  val (pf | time) = get_timer<timer><mcu>(atomic | (**))
  //Restart
  val () = time->ticks := 0u
  val _ = delayed_task_work<timer><mcu>(atomic | (**))
  prval () = return_timer(atomic, pf)
}