staload "SATS/timer.sats"
staload "SATS/interrupt.sats"

implement {t} {m} delayed_task(period) = {
  //Clear interrupts
  val prev = save_interrupts()
  val (clear | ()) = cli(prev)
  //Configure the timer
  val (pf | p) = get_timer(clear | (* *))
  val () = delayed_task_configure_timer(!p)
  prval () = return_timer(pf | p)
  //Restore interrupts
  val () = restore_interrupts(clear | prev)
}