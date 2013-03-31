(*
  A template based approach for atomic code.
*)

%{#
#include "CATS/atomic.cats"
%}

staload "SATS/interrupt.sats"

absview atomic

fun {a:t@ype} atomic_section(_: !atomic | env: a): void

fun {a:t@ype} atomic (env: a): void

fun atomic_cli(_: !saved_sreg): (atomic | void) = "mac#"

fun atomic_restore_sreg (_: atomic | _: saved_sreg): void = "mac#"

fun atomic_sei (_: atomic | ): (INT_SET | void) = "mac#sei"

fun sleep_cpu (_: atomic | ): (INT_SET | void) = "mac#sleep_cpu"

fun {a:t@ype} wait_until_body (
  pf: atomic | res: &a? >> opt(a, b)
): #[b:bool] (INT_SET | bool (b))

fun {a:t@ype} wait_until (_: !INT_SET | _: &a? >> a): void