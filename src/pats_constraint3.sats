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

abstype c3nstr_solver_type
typedef c3nstr_solver = c3nstr_solver_type

fun make_c3nstr_solver (): c3nstr_solver
fun stop_c3nstr_solver (_: c3nstr_solver): void

absview scope_v

fun c3nstr_solver_push (solver: c3nstr_solver): (scope_v | void)
fun c3nstr_solver_pop  (pf: scope_v | env: c3nstr_solver): void

fun c3nstr_solver_add_svar (env: c3nstr_solver, s2v: s2var): void

fun c3nstr_solver_assert_sbexp (
  env: c3nstr_solver, s2e: s2exp
): void

fun c3nstr_solver_is_valid (env: c3nstr_solver, exp: s2exp): bool

(* ****** ****** *)

fun s2exp_metdec_reduce (
  met: s2explst, met_bound: s2explst
) : s2exp

(* ****** ****** *)

(*
  
*)
absviewtype s3exp_viewtype
viewtypedef s3exp = s3exp_viewtype

fun f_identity (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_neg_bool (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_add_bool_bool (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_mul_bool_bool (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_eq_bool_bool (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_neq_bool_bool (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_neg_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_add_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_sub_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_mul_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_ndiv_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_idiv_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_lt_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_lte_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_gt_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_gte_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_eq_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_neq_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_abs_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_sgn_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_max_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_min_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

fun f_ifint_bool_int_int (
  env: c3nstr_solver, s2es: s2explst
) : s3exp

(* ****** ****** *)

fun s2exp_make_h3ypo (env: c3nstr_solver, h3p: h3ypo): s2exp
//
fun make_true (env: c3nstr_solver): s3exp
//
fun s2exp_make_h3ypo (env: c3nstr_solver, h3p: h3ypo): s2exp
//
fun s3exp_make (env: c3nstr_solver, s2e: s2exp): s3exp
//
// HX: these are auxiliary functions
//
fun s3exp_make_s2cst_s2explst
(
  env: c3nstr_solver, s2c: s2cst, s2es: s2explst
) : s3exp // end of [s3exp_make_s2cst_s2explst]

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
