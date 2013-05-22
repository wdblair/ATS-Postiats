(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: William Blair (wdblair AT cs DOT bu DOT edu)
// Start Time: April, 2013
//
(* ****** ****** *)

%{#
#include <z3.h>
#include <yices.h>
%}

#define ATS_STALOADFLAG 0

(* ****** ****** *)

#include "pats_params.hats"

(* ****** ****** *)

staload "pats_intinf.sats"

(* ****** ****** *)

absviewtype solver = ptr

//Default
#define __formula_size ptr
#define __sort_size ptr

#ifdef USE_Z3
#include "pats_smt_z3.hats"
#endif

#ifdef USE_YICES
#include "pats_smt_yices.hats"
#endif

abst@ype formula = __formula_size

abst@ype sort = __sort_size

(* ****** ****** *)

// Building Terms and Formulas

fun make_solver (): solver = "make_solver"

fun delete_solver (_: solver): void = "delete_solver"

fun make_int_sort (_: !solver): sort = "make_int_sort"

fun make_bool_sort (_: !solver): sort = "make_bool_sort"

fun make_constant (
  _: !solver, id: int, _: sort
): formula = "make_constant"

fun make_fresh_constant (
  _: !solver, _: sort
): formula = "make_fresh_constant"

(* ****** ****** *)

fun solver_push (
  _: !solver
): void = "solver_push"

fun solver_pop (
  _: !solver
): void = "solver_pop"

(* ****** ****** *)

// Prop Logic

fun make_and (
  _: !solver, _: List_vt(formula)
): formula = "make_and"

fun make_or (
  _: !solver, _: List_vt(formula)
): formula = "make_or"

fun make_not (
  _: !solver, _: formula
): formula = "make_not"

fun make_and2 (
  _: !solver, _: formula, _: formula
): formula = "make_and2"

fun make_or2 (
  _: !solver, _: formula, _: formula
): formula = "make_or2"

(* ****** ****** *)

// Arithmetic

symintr make_numeral 

fun make_numeral_int (
  _: !solver, _: int, _: sort
): formula = "make_numeral_int"

overload make_numeral with make_numeral_int

fun make_numeral_intinf (
  _: !solver, _: intinf, _: sort
): formula = "make_numeral_intinf"

overload make_numeral with make_numeral_intinf

fun make_add (_: !solver, _: List_vt(formula)): formula = "make_add_list"

fun make_add2 (_: !solver, _: formula, _: formula): formula = "make_add2"

//only need two multiplications
fun make_mul2 (_: !solver, _: formula, _: formula): formula = "make_mul"

fun make_lt (_: !solver, _: formula, _: formula): formula = "make_lt"
fun make_le (_: !solver, _: formula, _: formula): formula = "make_le"
fun make_gt (_: !solver, _: formula, _: formula): formula = "make_gt"
fun make_ge (_: !solver, _: formula, _: formula): formula = "make_ge"
fun make_eq (_: !solver, _: formula, _: formula): formula = "make_eq"

(* ****** ****** *)

// Solving

fun assert (_: !solver, _: formula): void = "assert"

sortdef status = {a: int | a >= ~1 ; a <= 1}

fun check (_: !solver): [s: status] int s = "check"

(* ****** ****** *)

// Debugging (SMT-Lib)

fun string_of_formula (
  _: !solver, _: !formula
): string = "string_of_formula"

(* ****** ****** *)
