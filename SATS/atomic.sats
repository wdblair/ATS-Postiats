(*
  A template based approach for atomic code.
*)

%{#
#include "CATS/atomic.cats"
%}

staload "SATS/interrupt.sats"

absview atomic

fun{a:t@ype} atomic_section(_: !atomic | env: a): void

fun{a:t@ype} atomic (env: a): void

fun atomic_cli(_: !saved_sreg): (atomic | void) = "mac#"

fun atomic_restore_sreg (_: atomic | _: saved_sreg): void = "mac#"
