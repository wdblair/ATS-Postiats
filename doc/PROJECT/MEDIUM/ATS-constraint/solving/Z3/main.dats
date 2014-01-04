(*
  A constraint solver built on top of the Z3 SMT solver.
  
  To make this more of a "platform", I think I need to enable
  developers to define their own s2cst fun map since that really
  is the engine behind adding power to the statics.
*)
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

implement main0 () = let
  val c3t = parse_c3nstr_from_stdin ()
in
  c3nstr_solve (c3t)
end