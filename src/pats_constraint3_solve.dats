(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: February, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

#include "./pats_params.hats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_constraint3_solve"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_patcst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

staload SMT = "./pats_smt.sats"
viewtypedef solver = $SMT.solver
typedef formula = $SMT.formula

(* ****** ****** *)

import Time = "contrib/time"

staload Time("time.sats")

(* ****** ****** *)

#include "pats_constraint3_solve_smt.hats"

(* ****** ****** *)
//
// HX-2012-03:
// for errmsg reporting; the function returns 0
// normally; if it returns 1, then the reported
// error should be treated as a warning instead.
//
extern fun
c3nstr_solve_errmsg (c3t: c3nstr, unsolved: uint): int
//
(* ****** ****** *)

extern fun
c3nstr_solve_main (
  env: &smtenv, c3t: c3nstr, unsolved: &uint, err: &int
) : int(*status*)
// end of [c3nstr_solve_main]

extern fun
c3nstr_solve_prop (
  loc0: location, env: &smtenv, s2p: s2exp, err: &int
) : int(*status*)
// end of [c3nstr_solve_prop]

extern fun
c3nstr_solve_itmlst (
  loc0: location
, env: &smtenv
, s3is: s3itmlst, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst]

extern fun
c3nstr_solve_itmlst_cnstr (
  loc0: location
, env: &smtenv
, s3is: s3itmlst, c3t: c3nstr, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst_cnstr]

extern fun
c3nstr_solve_itmlst_disj (
  loc0: location
, env: &smtenv
, s3is: s3itmlst, s3iss: s3itmlstlst, unsolved: &uint, err: &int
) : int(*status*) // end of [c3nstr_solve_itmlst_disj]

(* ****** ****** *)

extern
fun prerr_case_exhaustiveness_errmsg
(
  loc0: location, casknd: caskind, p2tcs: p2atcstlst
) : void // end of [prerr_case_exhaustiveness_errmsg]
implement
prerr_case_exhaustiveness_errmsg
  (loc0, casknd, p2tcs) = let
//
fun prlst (
  p2tcs: p2atcstlst
) : void = let
in
  case+ p2tcs of
  | list_cons
      (p2tc, p2tcs) => let
      val () =
        fprint_p2atcst (stderr_ref, p2tc)
      // end of [val]
      val () = fprint_newline (stderr_ref)
    in
      prlst (p2tcs)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [prlst]
//
in
//
case+ casknd of
| CK_case () => let
    val () = prerr_warning3_loc (loc0)
    val () = prerr ": pattern match is nonexhaustive:\n";
  in
    prlst (p2tcs)
  end // end of [CK_case]
| CK_case_pos () => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": pattern match is nonexhaustive:\n";
  in
    prlst (p2tcs)
  end // end of [CK_case]
| CK_case_neg => () // HX: ignored per the wish of the programmer
end // end of [prerr_case_exhaustiveness_errmsg]

(* ****** ****** *)

implement
c3nstr_solve_errmsg
  (c3t, unsolved) = let
//
val loc0 = c3t.c3nstr_loc
val c3tknd = c3t.c3nstr_kind
//
fn prerr_c3nstr_if (
  unsolved: uint, c3t: c3nstr
) : void =
  if (unsolved = 0u) then (prerr ": "; prerr_c3nstr c3t)
// end of [prerr_c3nstr_if]
//
in
//
case+ c3tknd of
| C3NSTRKINDmain () => (
    if unsolved > 0u then (
      0 // errmsg reporting has already be done
    ) else (
      prerr_error3_loc (loc0);
      prerr ": unsolved constraint: ";
      prerr_c3nstr (c3t);
      prerr_newline ();
      0 // it is treated as an error
    ) (* end of [if] *)
  ) // end of [C3STRKINDnone]
| C3NSTRKINDcase_exhaustiveness
    (casknd, p2tcs) => let
    val () = prerr_case_exhaustiveness_errmsg (loc0, casknd, p2tcs)
  in
    case+ casknd of
    | CK_case () => 1 (*warning*)
    | CK_case_pos () => 0 (*error*)
    | CK_case_neg () => 0 (*deadcode*)
  end // end of [C3NSTRKINDcase_exhaustiveness]
//
| C3NSTRKINDtermet_isnat
    () => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for termination metric being welfounded"
    val () = prerr_c3nstr_if (unsolved, c3t)
    val () = prerr_newline ()
  } // end of [C3NSTRKINDtermet_isnat]
| C3NSTRKINDtermet_isdec
    () => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for termination metric being decreasing"
    val () = prerr_c3nstr_if (unsolved, c3t)
    val () = prerr_newline ()
  } // end of [C3STRKINDmetric_dec]
//
| C3NSTRKINDsome_fin _ => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for var preservation"
    val () = prerr_newline ()
  } // end of [C3NSTRKINDsome_fin]
| C3NSTRKINDsome_lvar _ => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for lvar preservation"
    val () = prerr_newline ()
  } // end of [C3NSTRKINDsome_lvar]
| C3NSTRKINDsome_vbox _ => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for vbox preservation"
    val () = prerr_newline ()
  } // end of [C3NSTRKINDsome_vbox]
//
| C3NSTRKINDlstate () => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for lstate merging"
    val () = prerr_newline ()
  } // end of [C3NSTRKINDlstate]
| C3NSTRKINDlstate_var
    (d2v) => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = prerr ": unsolved constraint for merging the lstate of ["
    val () = prerr_d2var (d2v)
    val () = prerr "]"
    val () = prerr_newline ()
  } // end of [C3NSTRKINDlstate_var]
//
| C3NSTRKINDloop
    (knd) => 0 where {
    val () = prerr_error3_loc (loc0)
    val () = if knd < 0 then prerr ": unsolved constraint for loop(enter)"
    val () = if knd = 0 then prerr ": unsolved constraint for loop(exit)"
    val () = if knd > 0 then prerr ": unsolved constraint for loop(continue)"
    val () = prerr_newline ()
  } // end of [C3STRKINDloop]
//
end // end of [c3nstr_solve_errmsg]

(* ****** ****** *)

implement
c3nstr_solve_main
  (env, c3t, unsolved, err) = let
//
val loc0 = c3t.c3nstr_loc
(*
val () = begin
  print "c3nstr_solve_main: c3t = "; print_c3nstr (c3t); print_newline ();
end // end of [val]
*)
//
var status: int = (
//
// ~1: solved; 0: unsolved
//
  case+ c3t.c3nstr_node of
  | C3NSTRprop s2p =>
      c3nstr_solve_prop (loc0, env, s2p, err)
  | C3NSTRitmlst s3is =>
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
) : int // end of [val]
//
val () = if status >= 0 then {
  val iswarn =
    c3nstr_solve_errmsg (c3t, unsolved)
  // end of [val]
  val () = if iswarn > 0 then (status := ~1)
} // end of [val]
//
(*
val () = begin
  print "c3nstr_solve_main: status = "; print status; print_newline ()
end // end of [val]
*)
//
val () = if status >= 0 then (unsolved := unsolved + 1u)
//
in
  status (* 0: unsolved; ~1: solved *)
end // end of [c3nstr_solve_main]

(* ****** ****** *)

implement
c3nstr_solve_prop
  (loc0, env, s2p, err) = let
  val () = begin
    print "c3nstr_solve_prop: s2p = ";
    pprint_s2exp (s2p); print_newline ();
  end // end of [val]
in
  0
  // s3explst_solve_s2exp (loc0, env, s2p, err)
end // end of [c3nstr_solve_prop]

(* ****** ****** *)

implement
c3nstr_solve_itmlst
(
  loc0, env, s3is, unsolved, err
) = let
(*
val () = begin
  print "c3str_solve_itmlst: s3is = ";
  fprint_s3itmlst (stdout_ref, s3is); print_newline ();
end // end of [val]
*)
in
//
case+ s3is of
| list_cons (s3i, s3is) => (
  case+ s3i of
  | S3ITMsvar (s2v) => let
      val () = smtenv_add_svar (env, s2v)
    in
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
    end // end of [S3ITMsvar]
  | S3ITMhypo (h3p) => let
      // Assert the assumption
      val prop = s2exp_make_h3ypo (env, h3p)
      // val s3p = s3exp_make_h3ypo (env, h3p)
      val () = (
        case+ prop.s2exp_node of
        | S2Eerr _ => let
            val () = begin
              prerr_warning3_loc (loc0);
              prerr ": unused hypothesis: ["; prerr_h3ypo (h3p); prerr "]";
              prerr_newline ()
            end // end of [val]
*)
          in
            // nothing
          end // end of [S3Eerr]
        | _ => smtenv_assert_sbexp (env, prop)
      ) : void // end of [val]
    in
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
    end // end of [S3ITMhypo]
  | S3ITMsVar (s2V) =>
      c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
  | S3ITMcnstr c3t =>
      c3nstr_solve_itmlst_cnstr (loc0, env, s3is, c3t, unsolved, err)
  | S3ITMcnstr_ref (ctr) => let
      val ref = ctr.c3nstroptref_ref
    in
      case+ !ref of
      | Some c3t =>
          c3nstr_solve_itmlst_cnstr (loc0, env, s3is, c3t, unsolved, err)
      | None () => ~1(*solved*)
    end // end of [S3ITMcnstr_ref]
  | S3ITMdisj (s3iss_disj) =>
      c3nstr_solve_itmlst_disj (loc0, env, s3is, s3iss_disj, unsolved, err)
  ) // end of [list_cons]
| list_nil () => ~1(*solved*)
//
end // end of [c3nstr_solve_itmlst]

(* ****** ****** *)

implement
c3nstr_solve_itmlst_cnstr
(
  loc0, env, s3is, c3t, unsolved, err
) = let
  val (pf1 | ()) = smtenv_push (env)
  val (pf2 | ()) = the_s2varbindmap_push ()
  val ans1 =
    c3nstr_solve_main (env, c3t, unsolved, err)
  // end of [val]
  val () = the_s2varbindmap_pop (pf2 | (*none*))
  val () = smtenv_pop (pf1 | env)
  val ans2 =
    c3nstr_solve_itmlst (loc0, env, s3is, unsolved, err)
  // end of [val]
in
  if ans1 >= 0 then 0(*unsolved*) else ans2
end // end of [c3nstr_solve_itmlst_cnstr]

(* ****** ****** *)

implement
c3nstr_solve_itmlst_disj (
  loc0, env, s3is0, s3iss(*disj*), unsolved, err
) = let
(*
val () = (
  print "c3nstr_solve_itmlst_disj: s3iss = ..."; print_newline ()
) // end of [val]
*)
in
//
case+ s3iss of
| list_cons (s3is, s3iss) => let
    val (pf1 | ()) = smtenv_push (env)
    val (pf2 | ()) = the_s2varbindmap_push ()
    val s3is1 = list_append (s3is, s3is0)
    val ans = c3nstr_solve_itmlst (loc0, env, s3is1, unsolved, err)
    val () = the_s2varbindmap_pop (pf2 | (*none*))
    val () = smtenv_pop (pf1 |env)
  in
    c3nstr_solve_itmlst_disj (loc0, env, s3is0, s3iss, unsolved, err)
  end // end of [list_cons]
| list_nil () => ~1 (*solved*)
//
end // end of [c3nstr_solve_itmlst_disj]

(* ****** ****** *)

implement
c3nstr_solve (c3t) = let
(*
  val () = begin
    print "c3nstr_solve: c3t = "; print_c3nstr(c3t); print_newline ()
  end // end of [val]
*)
  var env : smtenv
  val _ = smtenv_nil(env)
//
// HX-2010-09-09: this is needed for solving top-level constraints!!!
  val () = the_s2varbindmap_freetop ()
//
  var unsolved: uint = 0u and err: int = 0
  val _(*status*) = c3nstr_solve_main (env, c3t, unsolved, err)
  val () = smtenv_free (env)
in
//
case+ 0 of
| _ when unsolved = 0u => let
(*
    val () = (
      prerr "typechecking is finished successfully!"; prerr_newline ()
    ) // end of [val]
*)
  in
    // nothing
  end // end of [unsolved = 0]
| _ => { // unsolved > 0
    val () = prerr "typechecking has failed"
    val () = if unsolved <= 1u then
      prerr ": there is one unsolved constraint"
    val () = if unsolved >= 2u then
      prerr ": there are some unsolved constraints"
    val () = (
      prerr ": please inspect the above reported error message(s) for information."
    ) // end of [val]
    val () = prerr_newline ()
    val () = $ERR.abort {void} ()
  } // end of [_]
//
end // end of [c3nstr_solve]


(* ****** ****** *)

(* end of [pats_constraint3_solve.dats] *)
