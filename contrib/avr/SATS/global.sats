(* 
  An interface for global variables.
*)

%{#
#include "CATS/global.cats"
%}

staload "SATS/interrupt.sats"

viewtypedef global(v:view, l:addr) = @{
  at= v,
  p= ptr l
}

(* For global variables not shared with ISRs. *)

fun global_new {v:view} {l:addr} (
  pf: v | p: ptr l
):<> global(v, l) = "mac#global_new"

absprop viewlock(v:view)

praxi viewlock_new {v:view} (): viewlock(v)

praxi viewlock{v:view} (
  v: viewlock(v)
): v

praxi viewunlock {v:view} (
  v: viewlock(v), pf: v
): void

abst@ype viewkey(v:view, l:addr) = @{
  lock= viewlock(v),
  p = ptr l
}

(*
  This is designed to make a viewlock
  around static global variables
  defined in C.
*)
fun viewkey_make {a:t@ype} {l:addr} (
  p: ptr l
): viewkey(a @ l, l) = "mac#"

praxi global_return {v:view} {l:addr} (
  l: viewkey(v, l), pf: v
): void

fun global_get {v:view} {l:addr} (
  g: viewkey(v, l)
): (v | ptr l) = "mac#global_get"

(* Locking Proof Functions (For Variables Shared with ISRs) *)

absprop interrupt_lock (view)

viewtypedef sharedkey(v:view, l:addr) = @{
  lock= interrupt_lock(v),
  p = ptr l
}

praxi interrupt_lock_new {v:view} (
  pf: v
): interrupt_lock(v)

symintr lock

fun lock_interrupts_cleared {v:view} {l:addr} (
  pf: INT_CLEAR | g: sharedkey(v, l)
): (atomic, v | ptr l) = "mac#global_shared_get"

overload lock with lock_interrupts_cleared

fun unlocked {v:view} {l:addr} (
  pf: !atomic | g: sharedkey(v, l)
): (vbox v | ptr l)

praxi unlock {v:view} {l:addr} (
  pf: atomic, sh: sharedkey(v, l), pf: v
): (INT_CLEAR | void) = "mac#global_shared_get"