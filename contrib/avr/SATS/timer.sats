staload "SATS/io.sats"
staload "SATS/global.sats"
staload "SATS/atomic.sats"

%{#
#include "CATS/timer.cats"
%}

typedef hardware_timer (n:int) = $extype_struct "hardware_timer_t" of {
  threshold= uint n,
  ticks= [t:nat | t <= n] uint t
}

sortdef timer = tkind 

stacst timer0 : timer
stacst timer1 : timer
stacst timer2 : timer

(* ****** ****** *)

//Templates for interacting with timers

fun {t:timer} {m:mcu} get_timer (pf: !atomic | (* *)):
   [l:addr] ([n:pos] hardware_timer(n) @ l | ptr l)

praxi return_timer {t:timer} {m:mcu} {l:addr} {n:pos} (
  atom: !atomic, pf: hardware_timer(n) @ l
): void

(* ******* ****** *)

(*
    Should not be a long running computation, unless I want to
    enable interrupts after the timer overflow. That's not the
    best idea.
*)
fun {t:timer} {m:mcu} delayed_task_work(pf: !atomic | (* none *)): bool

fun {t:timer} {m:mcu} delayed_task_configure_timer {n:nat} {p:pos} (
  t: &hardware_timer(n) >> hardware_timer(n'), period: uint p
): #[n':pos] void

fun {t:timer} {m:mcu} delayed_task {p:pos} (
  period: uint p
): void

(*
  Timer_overflow should only be called inside an ISR
*)
fun {t:timer} {m:mcu} timer_overflow  (
  pf: !atomic | (* *)
): void
