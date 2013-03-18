staload "SATS/io.sats"
staload "SATS/global.sats"
staload "SATS/interrupt.sats"

typedef timer_t (n:int) = $extype_struct "timer_t" of {
  threshold= uint n,
  ticks= [t:nat | t <= n] uint t
}

sortdef timer = tkind 

stacst timer0 : timer
stacst timer1 : timer
stacst timer2 : timer

(* ****** ****** *)

//The templates for interacting with timers

fun {t:timer} {m:mcu} get_timer(pf: !INT_CLEAR | (* *)):
  [n:int] [l:addr] (timer_t(n) @ l | ptr l)

prfun {t:timer} {m:mcu} return_timer {l:addr} {n:int} (
  pf: timer_t(n) @ l | ptr l
): void

(* ******* ****** *)

(*
  Should not be a long running computation, unless I want to
  enable interrupts after the timer overflow.
*)
fun {t:timer} {m:mcu} delayed_task_work(): bool

fun {t:timer} {m:mcu} delayed_task_configure_timer {n:int} (
  t: &timer_t(n)
): void

fun {t:timer} {m:mcu} delayed_task (
  period: ulint
): void

//timer_overflow should only be called inside a timer's ISR.

fun timer_overflow {t:timer} {m:mcu} (
  pf: !INT_CLEAR | (* *)
): void