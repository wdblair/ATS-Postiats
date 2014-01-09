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

absvtype solver = ptr

#ifndef __formula_size
#define __formula_size ptr
#define __sort_size ptr
#endif

absvt@ype formula = __formula_size
absvt@ype sort = __sort_size

(* ****** ****** *)

// Building Terms and Formulas

fun make_solver (): solver

fun delete_solver (solver): void

fun make_int_sort (!solver): sort

fun make_bool_sort (!solver): sort

fun make_bitvec_sort (_: !solver, width: int): sort

fun make_int_constant (
  _: !solver, id: int, _: !sort
): formula

fun make_fresh_constant (
  _: !solver, _: !sort
): formula

(* ****** ****** *)

// Prop Logic and Equality

fun make_true  (!solver): formula
fun make_false (!solver): formula

fun make_not (
  _: !solver, _: formula
): formula

fun make_and2 (
  !solver, formula, formula
): formula

fun make_or2 (
  !solver, formula, formula
): formula

fun make_ite (
  !solver, condition: formula, t: formula, f: formula
): formula

(* ****** ****** *)

// Integer Arithmetic

symintr make_numeral

fun make_numeral_int (
  !solver, int, !sort
): formula

overload make_numeral with make_numeral_int

fun make_numeral_string (
  !solver, string, !sort
): formula

overload make_numeral with make_numeral_string

fun make_numeral_uninterpreted (
  _: !solver, _: !sort
): formula = "make_int"

overload make_numeral with make_numeral_uninterpreted

fun make_negate (!solver, formula): formula

fun make_add2 (!solver, formula, formula): formula

fun make_sub2 (!solver, formula, formula): formula

fun make_mul2 (!solver, formula, formula): formula

fun make_div ( !solver,  formula,  formula): formula

fun make_lt ( !solver,  formula,  formula): formula
fun make_le ( !solver,  formula,  formula): formula
fun make_gt ( !solver,  formula,  formula): formula
fun make_ge ( !solver,  formula,  formula): formula
fun make_eq ( !solver,  formula,  formula): formula

(* ****** ****** *)

// Bit Vectors

fun make_bv_from_int (solv: !solver, width: int, i: formula): formula

fun make_bv_sub2 (!solver, formula, formula): formula

fun make_bv_add2 (!solver, formula, formula): formula

fun make_bv_land2 (!solver, formula, formula): formula

fun make_bv_eq (!solver, formula, formula): formula

(* ****** ****** *)

// Solving

fun push (
  !solver
): void

fun pop (
  !solver
): void

fun assert (!solver, formula): void

fun is_valid (!solver, formula): bool

(* ****** ****** *)

fun formula_dup (!solver, !formula): formula

fun formula_free (!solver, formula): void

fun sort_free (!solver, sort): void

(* ****** ****** *)

// Debugging (SMT-Lib)

fun string_of_formula (
  !solver, !formula
): string

(* ****** ****** *)
