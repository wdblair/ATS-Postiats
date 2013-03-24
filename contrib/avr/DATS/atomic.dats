staload "SATS/interrupt.sats"
staload "SATS/atomic.sats"

implement {a} atomic(itm) = {
  val sreg = save_sreg()
  val (cs | ()) = atomic_cli(sreg)
  val () = atomic_section<a>(cs | itm)
  val () = atomic_restore_sreg(cs | sreg)
}