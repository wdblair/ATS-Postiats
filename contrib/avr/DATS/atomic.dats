staload "SATS/interrupt.sats"
staload "SATS/atomic.sats"

implement {a} atomic(itm) = {
  val sreg = save_sreg()
  val (cs | ()) = atomic_cli(sreg)
  val () = atomic_section<a>(cs | itm)
  val () = atomic_restore_sreg(cs | sreg)
}

local 
  extern
  praxi make_atomic (_: INT_CLEAR): atomic
in

  implement {a} atomic_wait (enabled | res) = let 
      val (blocked | ()) = cli(enabled | )
      prval atom = make_atomic(blocked)
      val (set | stop) = atomic_wait_body<a>(atom | res)
      prval () = enabled := set
  in
    if stop then {
      prval () = opt_unsome(res)
    } else let
      prval () = opt_unnone(res)
    in 
      atomic_wait<a>(enabled | res)
    end
  end
end