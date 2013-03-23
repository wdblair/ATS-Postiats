(*
   Functions manipulating the global interrupt flag.
*)

%{#
#include "CATS/interrupt.cats"
%}

absview INT_CLEAR
absview INT_SET

absview atomic

(* ****** ****** *)

fun cli (
  pf: INT_SET | (* none *)
): (INT_CLEAR | void ) = "mac#cli"

fun sei (
  pf: INT_CLEAR | (* none *)
):  (INT_SET | void) = "mac#sei"