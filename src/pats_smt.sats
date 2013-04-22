%{#
#include <z3.h>
#include <yices.h>
%}

#define ATS_STALOADFLAG 0

(* ****** ****** *)

staload "pats_lintprgm.sats"

(* ****** ****** *)

absviewtype solver = ptr

// #include "pats_smt_z3.hats"
#include "pats_smt_yices.hats"

// Yices - 32bit integers
// Z3 - pointers
abst@ype formula = __formula_size

abst@ype sort = __sort_size

(* ****** ****** *)

// Building Terms and Formulas

fun make_solver (): solver = "make_solver"

fun delete_solver(_: solver): void = "delete_solver"

fun make_int_sort (_: !solver): sort = "make_int_sort"

fun make_constant (
  _: !solver, id: int, _: sort
): formula = "make_constant"

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

(* ****** ****** *)

// Arithmetic

fun {a:t@ype} make_numeral (
  _: !solver, _: !myint(a), _: sort
): formula = "make_numeral"

fun make_numeral_int (
  _: !solver, _: int, _: sort
): formula = "make_numeral_int"

fun make_add (_: !solver, _: List_vt(formula)): formula = "make_add"

//only need two multiplications
fun make_mul (_: !solver, _: formula, _: formula): formula = "make_mul"

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
  _: !solver, _: formula
): string = "string_of_formula"

(* ****** ****** *)
