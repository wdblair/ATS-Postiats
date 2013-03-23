(*
   Functions manipulating the global interrupt flag.
*)

%{#
#include "CATS/interrupt.cats"
%}

sortdef interrupt = int

absview INT_CLEAR(interrupt)
absview INT_SET(interrupt)

(* ****** ****** *)

absviewt@ype saved_sreg = uint8

symintr cli

fun cli_explicit {id:interrupt} (
  pf: INT_SET(id) | (* none *)
): [id':interrupt] (INT_CLEAR(id') | void ) = "mac#cli"

overload cli with cli_explicit

fun cli_saved (
  saved: !saved_sreg
): [id:interrupt] (INT_CLEAR(id) | void) = "mac#cli_saved"
  
overload cli with cli_saved

symintr sei

fun sei_explicit {id:interrupt} (
  pf: INT_CLEAR(id) | (* none *) 
): [id':interrupt] (INT_SET(id') | void) = "mac#sei"
  
overload sei with sei_explicit

fun sei_saved (
  saved: !saved_sreg
): [id:int] (INT_SET(id) | void ) = "mac#sei_saved"

overload sei with sei_saved

fun save_interrupts (): saved_sreg = "mac#"

symintr restore_interrupts

fun restore_interrupts_clear {id:interrupt} (
  pf: INT_CLEAR(id) | saved: saved_sreg
): void = "mac#restore_interrupts"

overload restore_interrupts with restore_interrupts_clear

fun restore_interrupts_set {id:interrupt} (
  pf: INT_SET(id) | saved: saved_sreg
): void = "mac#restore_interrupts"

overload restore_interrupts with restore_interrupts_set