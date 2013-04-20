%{#
#include <z3.h>
%}

#define ATS_STALOADFLAG 0

(* ****** ****** *)

absviewtype solver = ptr

abstype symbol = ptr

abstype formula = ptr

abstype sort = ptr

(* ****** ****** *)

// Building Terms and Formulas

fun make_solver (): solver = "make_solver"

fun delete_solver(_: solver): void = "delete_solver"

fun make_int_sort (_: !solver): sort = "make_int_sort"

fun make_int_symbol (
  _: !solver, _: int
): symbol = "make_int_symbol"

fun make_constant (
  _: !solver, _: symbol, _: sort
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

fun make_numeral (
  _: !solver, _: string, _: sort
): formula = "make_numeral"

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

#define UNSAT 0
#define SAT 1
#define UNKNOWN 2

fun check (_: !solver): [s: status] int s = "check"

(* ****** ****** *)

// Debugging (SMT-Lib)

fun string_of_formula (
  _: !solver, _: formula
): string = "string_of_formula"

(* ****** ****** *)
