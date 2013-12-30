#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "parsing/parsing.sats"

staload "solving/solver.sats"

(* ****** ****** *)

dynload "../../dynloadall.dats"
dynload "../../parsing/dynloadall.dats"

(* ****** ****** *)

implement main0 () = ()