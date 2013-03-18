staload "SATS/timer.sats"

implement {t} {m} delayed_task(period) = {
  //Clear interrupts
  val (pf | p) = get_timer()
  val () = delayed_task_configure_timer(!p)
  
  
  
  //Restore interrupts
  prval () = return_timer(pf | p)
}