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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_constraint3"

(* ****** ****** *)

staload INTINF = "./pats_intinf.sats"
typedef intinf = $INTINF.intinf

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

staload SMT = "./pats_smt.sats"
viewtypedef formula = $SMT.formula

(* ****** ****** *)

staload "./pats_error.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

local

fun synlt_s2hnf_s2hnf (
  s2f1: s2hnf, s2f2: s2hnf
) : bool = let
  val s2e2 = s2hnf2exp s2f2
(*
  val () = begin
    print "synlt_s2hnf_s2hnf: s2f1 = "; print_s2hnf (s2f1); print_newline ();
    print "synlt_synlt_s2hnf: s2f2 = "; print_s2hnf (s2f2); print_newline ();
  end // end of [val]
*)
in
  case+ s2e2.s2exp_node of
  | S2Eapp (_, s2es2) => synlte_s2hnf_s2explst (s2f1, s2es2)
  | _ => false
end // end pf [s2exp_synlt]

and synlte_s2hnf_s2hnf
  (s2f1: s2hnf, s2f2: s2hnf): bool =
  s2hnf_syneq (s2f1, s2f2) orelse synlt_s2hnf_s2hnf (s2f1, s2f2)
(* end of [synlte_s2hnf_s2hnf] *)

//
// HX-2012-02:
// [s2f1] <= at least one of [s2es2]
//
and synlte_s2hnf_s2explst
  (s2f1: s2hnf, s2es2: s2explst): bool =
  case+ s2es2 of
  | list_cons
      (s2e2, s2es2) => let
      val s2f2 = s2exp2hnf (s2e2)
    in
      if synlte_s2hnf_s2hnf (s2f1, s2f2)
        then true else synlte_s2hnf_s2explst (s2f1, s2es2)
      // end of [if]
    end // end of [list_cons]
  | list_nil () => false
// end of [synlte_s2hnf_s2explst]

in // in of [local]

fun s2exp_synlt (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlt_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

fun s2exp_synlte (
  s2e1: s2exp, s2e2: s2exp
) : bool = let
  val s2f1 = s2exp2hnf (s2e1) and s2f2 = s2exp2hnf (s2e2)
in
  synlte_s2hnf_s2hnf (s2f1, s2f2)
end // end of [s2exp_synlt]

end // end of [local]

(* ****** ****** *)

local

fun auxlt (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lt: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlt (s2e1, s2e2)
  else let
    val islt = s2exp_synlt (s2e1, s2e2)
    val () = (if islt then lt := 1 else lt := ~1): void
  in
    s2exp_bool (islt)
  end // end of [if]
// end of [auxlt]
//
fun auxlte (
  isint: bool
, s2e1: s2exp, s2e2: s2exp
, lte: &int(0) >> int
) : s2exp =
  if isint then
    s2exp_intlte (s2e1, s2e2)
  else let
    val islte = s2exp_synlte (s2e1, s2e2)
    val () = (if islte then lte := 1 else lte := ~1): void
  in
    s2exp_bool (islte)
  end // end of [if]
//
fun auxlst (
  s2es1: s2explst, s2es2: s2explst
) : s2exp = let
(*
  val () = (
    print "s2exp_metdec_reduce: auxlst"; print_newline ()
  ) // end of [val]
*)
in
//
case+ s2es1 of
| list_cons
    (s2e1, s2es1) => let
    var lt: int = 0 and lte: int = 0
  in
    case+ s2es2 of
    | list_cons
        (s2e2, s2es2) => let
        val isint = s2rt_is_int (s2e1.s2exp_srt)
        val s2p_lt = auxlt (isint, s2e1, s2e2, lt)
      in
        case+ lt of
        | _ when lt > 0 => s2p_lt (*true*)
        | _ (* lt <= 0 *) => let
            val s2p_lte = auxlte (isint, s2e1, s2e2, lte)
          in
            if lt = 0 then let
              val s2p_rest = auxlst (s2es1, s2es2)
            in
              s2exp_badd (s2p_lt, s2exp_bmul (s2p_lte, s2p_rest))
            end else ( // lt < 0 // HX: lte != 0
              if lte >= 0 then auxlst (s2es1, s2es2) else s2p_lte (*false*)
            ) // end of [if]
          end // end of [lt <= 0]
        // end of [case]
      end // end of [list_cons]
    | list_nil () => s2exp_bool (true)
  end (* end of [list_cons] *)
| list_nil () => s2exp_bool (false)
end // end of [auxlst]

in // in of [local]

implement s2exp_metdec_reduce (met, met_bound) = (
  auxlst (met, met_bound)
) // end of [s2exp_metdec_reduce]

end // end of [local]

(* ****** ****** *)

local

fun auxeq (
  env: &smtenv, s2e1: s2exp, s2e2: s2exp
) : s2exp = let
  val s2t1 = s2e1.s2exp_srt
(*
val () = println! ("auxeq: s3e1 = ", s3e1)
and () = println! ("auxeq: s3e2 = ", s3e2)
*)
//
in
case+ 0 of
  | _ when s2rt_is_int  (s2t1) => s2exp_eqeq (s2e1, s2e2)
  | _ when s2rt_is_addr (s2t1) => s2exp_eqeq (s2e1, s2e2)
  | _ when s2rt_is_bool (s2t1) => s2exp_eqeq (s2e1, s2e2)
  | _ when s2rt_is_char (s2t1) => s2exp_eqeq (s2e1, s2e2)
  | _ => (
      if s2exp_syneq (s2e1, s2e2) then s2exp_bool(true) else s2exp_err (s2rt_bool)
  ) // end of [_]
//
end // end of [auxeq]

fun auxbind (
  loc0: location
, env: &smtenv, s2v1: s2var, s2e2: s2exp
) : s2exp = let
(*
  val () = begin
    print "auxbind: s2v1 = "; print_s2var (s2v1); print_newline ();
    print "auxbind: s2e2 = "; print_s2exp (s2e2); print_newline ();
  end // end of [val]
*)
  val s2e1 = s2exp_var (s2v1)
  val s2be = auxeq (env, s2e1, s2e2)
  val s2f2 = s2exp2hnf (s2e2)
  val () = trans3_env_hypadd_bind (loc0, s2v1, s2f2)
in
  s2be
end // end of [aux_bind]

in // in of [local]

(*
implement
s2exp_make_h3ypo
  (env, h3p) = (
  case+ h3p.h3ypo_node of
  | H3YPOprop s2p => s2p
  | H3YPObind (s2v1, s2e2) => auxbind (h3p.h3ypo_loc, env, s2v1, s2e2)
  | H3YPOeqeq (s2e1, s2e2) => auxeq (env, s2e1, s2e2)
) // end of [s2exp_make_h3ypo]

end // end of [local]

(* ****** ****** *)

local

stadef env = smtenv
typedef tfun = (&env, s2explst) -<fun1> formula

assume
s2cfunmap = s2cstmap (tfun)
var the_s2cfunmap: s2cfunmap = s2cstmap_nil ()
val (pf_the_s2cfunmap | ()) =
  vbox_make_view_ptr {s2cfunmap} (view@ (the_s2cfunmap) | &the_s2cfunmap)
// end of [val]

in // in of [local]

  implement
  formula_make_s2cst_s2explst
    (env, s2c, s2es) = let
    val opt = let
      prval vbox (pf) = pf_the_s2cfunmap in s2cstmap_find (the_s2cfunmap, s2c)
    end // end of [val]
  //
  (*
  val () = println! ("formula_make_s2cst_s2explst: s2c = ", s2c)
  val () = println! ("formula_make_s2cst_s2explst: s2es = ", s2es)
  *)
  in
    case+ opt of
      | ~Some_vt f => f (env, s2es)
      | ~None_vt _ => make_true (env)
  end // end of [formula_make_s2cst_s2explst]

(* ****** ****** *)

implement
constraint3_initialize () = let
  prval vbox (pf) = pf_the_s2cfunmap in
  $effmask_ref (constraint3_initialize_map (the_s2cfunmap))
end // end of [constraint3_initialize]

end // end of [local]

(* ****** ****** *)

(* end of [pats_constraint3.dats] *)
