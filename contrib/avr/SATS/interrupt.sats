(*
   Functions and types for manipulating the global interrupts flag.
*)

%{#
#include "CATS/interrupt.cats"
%}

absview INT_CLEAR
absview INT_SET

absviewt@ype saved_sreg = uint8

(* ****** ****** *)

fun cli (
  pf: INT_SET | (* none *)
): (INT_CLEAR | void) = "mac#cli"

fun sei (
  pf: INT_CLEAR | (* none *)
):  (INT_SET | void) = "mac#sei"

(* ****** ****** *)

fun save_sreg (): saved_sreg = "mac#"

(* ****** ****** *)