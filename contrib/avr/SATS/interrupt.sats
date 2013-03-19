(*
   Functions manipulating the global interrupt flag.
*)

%{#
#include "CATS/interrupt.cats"
%}

absview INT_CLEAR
absview INT_SET

(* ****** ****** *)

absviewt@ype saved_sreg = uint8

symintr cli

fun cli_explicit (
  pf: INT_SET | (* none *)
): (INT_CLEAR | void ) = "mac#cli"

overload cli with cli_explicit

fun cli_saved (
  saved: !saved_sreg
): (INT_CLEAR | void ) = "mac#cli_saved"
  
overload cli with cli_saved

symintr sei

fun sei_explicit (
  pf: INT_CLEAR | (* none *) 
): (INT_SET | void ) = "mac#sei"
  
overload sei with sei_explicit

fun sei_saved (
  saved: !saved_sreg
): (INT_SET | void ) = "mac#sei_saved"

overload sei with sei_saved

fun save_interrupts (): saved_sreg = "mac#"

symintr restore_interrupts

fun restore_interrupts_clear (
  pf: INT_CLEAR | saved: saved_sreg
): void = "mac#restore_interrupts"

overload restore_interrupts with restore_interrupts_clear

fun restore_interrupts_set (
  pf: INT_SET | saved: saved_sreg
): void = "mac#restore_interrupts"

overload restore_interrupts with restore_interrupts_set