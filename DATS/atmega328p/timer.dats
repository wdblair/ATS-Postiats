staload "SATS/io.sats"
staload "SATS/global.sats"
staload "SATS/timer.sats"

staload "prelude/DATS/integer.dats"

staload "DATS/atmega328p/io.dats"

stadef m = atmega328p

(*
  Timers 0 and 1 are 8-bit
  Timer 2 is 16-bit
*)

%{#
declare_isr(TIMER0_OVF_vect);
%}

(*
  Remove this after I find a way to go from
  ulint to uint1 using the g1int functions.
*)
extern
castfn uint1_of_ulint (_: ulint): [n:nat] uint n

local
  stacst timer0_addr : addr

  extern
  prval pf_locked : interrupt_lock([n:nat] hardware_timer(n) @ timer0_addr)
  
  macdef t0imer = $extval(ptr timer0_addr, "&t0imer")
in

  implement get_timer<timer0><m>(pf | (**) ) =
    (locked_pf(pf, pf_locked) | t0imer)
    
  implement delayed_task_configure_timer<timer0><m> (timer, period) = {
    val () = begin
      timer.threshold := uint1_of_ulint((F_CPU / (1024ul * 256ul)) * period);
      timer.ticks := 0u;
      //Configure the registers
      clearbits(TCCR0A<m>(), WGM01, WGM00);
      clearbits(TCCR0B<m>(), WGM02);
      setbits(TCCR0B<m>(), CS02, CS00);
      setbits(TIMSK0<m>(), TOIE0);
    end
  }
  
end
