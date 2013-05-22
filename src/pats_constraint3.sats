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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload
TRENV3 = "./pats_trans3_env.sats"
typedef h3ypo = $TRENV3.h3ypo
typedef c3nstr = $TRENV3.c3nstr

(* ****** ****** *)

staload "./pats_smt.sats"

(* ****** ****** *)

fun formula_cst (s2c: s2cst): formula

(* ****** ****** *)

(* 
  smtenv  is similar  to s2vbcfenv,  but it  doesn't explicitely  keep
  track  of  any propositions.  Only  an  SMT  solver context  and  an
  environment of static variables.
*)
absviewt@ype smtenv_viewtype = @{smt=ptr, vars=ptr}
viewtypedef smtenv = smtenv_viewtype

fun smtenv_nil (env: &smtenv? >> smtenv): void
fun smtenv_free (env: &smtenv >> smtenv?): void

absview smtenv_push_v

fun smtenv_push (env: &smtenv): (smtenv_push_v | void)
fun smtenv_pop  (pf: smtenv_push_v | env: &smtenv): void

fun smtenv_add_svar (env: &smtenv, s2v: s2var): void
fun smtenv_get_var_exn (env: &smtenv, s2v: s2var): formula
fun smtenv_assert_sbexp (env: &smtenv, s2e: s2exp): void
fun smtenv_assert_formula (env: &smtenv, fm: formula): void

fun smtenv_check (env: &smtenv): int

(* ****** ****** *)

fun s2exp_metdec_reduce (
  met: s2explst, met_bound: s2explst
) : s2exp

(* ****** ****** *)

fun f_identity (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neg_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_add_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_mul_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_eq_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neq_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neg_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_add_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_sub_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_mul_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_ndiv_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_idiv_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_lt_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_lte_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_gt_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_gte_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_eq_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neq_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_abs_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_sgn_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_max_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_min_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_ifint_bool_int_int (
  env: &smtenv, s2es: s2explst
) : formula

(* ****** ****** *)

fun s2exp_make_h3ypo (env: &smtenv, h3p: h3ypo): s2exp
//
fun formula_make (env: &smtenv, s2e: s2exp): formula
//
fun make_true (env: &smtenv): formula
//
fun s2exp_make_h3ypo (env: &smtenv, h3p: h3ypo): s2exp
//
// HX: these are auxiliary functions
//
fun formula_make_s2cst_s2explst
(
  env: &smtenv, s2c: s2cst, s2es: s2explst
) : formula // end of [s3exp_make_s2cst_s2explst]

(* ****** ****** *)

#define TAUTOLOGY (1)
#define UNDECIDED (0)
#define CONTRADICTION (~1)

(* ****** ****** *)

*)

fun c3nstr_solve (c3t: c3nstr): void

(* ****** ****** *)
//
abstype s2cfunmap
//
fun constraint3_initialize (): void
fun constraint3_initialize_map (map: &s2cfunmap): void
//
(* ****** ****** *)

(* end of [pats_constraint3.sats] *)
