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

abstype constraint_solver_type
typedef constraint_solver = constraint_solver_type

absviewtype formula_viewtype
viewtypedef formula = formula_viewtype

fun make_constraint_solver (): constraint_solver

absview scope_v

fun constraint_solver_push (solver: constraint_solver): (scope_v | void)
fun constraint_solver_pop  (pf: scope_v | env: constraint_solver): void

fun constraint_solver (env: constraint_solver, s2v: s2var): void

fun constraint_solver_assert_sbexp (
  env: constraint_solver, s2e: s2exp
): void

fun constraint_solver_is_valid (env: constraint_solver, exp: s2exp): bool

(* ****** ****** *)

fun s2exp_metdec_reduce (
  met: s2explst, met_bound: s2explst
) : s2exp

(* ****** ****** *)

fun f_identity (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_neg_bool (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_add_bool_bool (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_mul_bool_bool (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_eq_bool_bool (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_neq_bool_bool (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_neg_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_add_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_sub_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_mul_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_ndiv_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_idiv_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_lt_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_lte_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_gt_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_gte_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_eq_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_neq_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_abs_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_sgn_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_max_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_min_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

fun f_ifint_bool_int_int (
  env: constraint_solver, s2es: s2explst
) : formula

(* ****** ****** *)

fun s2exp_make_h3ypo (env: constraint_solver, h3p: h3ypo): s2exp
//
fun make_true (env: constraint_solver): formula
//
fun s2exp_make_h3ypo (env: constraint_solver, h3p: h3ypo): s2exp
//
fun formula_make (env: constraint_solver, s2e: s2exp): formula
//
// HX: these are auxiliary functions
//
fun formula_make_s2cst_s2explst
(
  env: constraint_solver, s2c: s2cst, s2es: s2explst
) : formula // end of [s3exp_make_s2cst_s2explst]

(* ****** ****** *)

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
