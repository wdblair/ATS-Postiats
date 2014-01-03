#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "parsing/parsing.sats"
staload "solving/solver.sats"

(* ****** ****** *)

dynload "constraint_dynload.dats"
dynload "parsing/parsing_dynload.dats"
dynload "solving/solver_dynload.dats"
dynload "solving/Z3/z3_dynload.dats"

(* ****** ****** *)

implement main0 () = ()