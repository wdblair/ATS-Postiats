%{#
#include <z3.h>
%}

#define ATS_STALOADFLAG 0

(* ****** ****** *)

absviewtype solver = ptr

abstype symbol = ptr

abstype constant = ptr

abstype formula = ptr

abstype sort = ptr

(* ****** ****** *)

// Building Terms and Formulas

fun make_solver (): solver = "mac#"

fun delete_solver(_: solver): void = "mac#"

fun make_int_sort (_: !solver): sort = "mac#"

fun make_int_symbol (
  _: !solver, _: int
): symbol = "mac#"

fun make_constant (
  _: !solver, _: symbol, _: sort
): formula = "mac#"

(* ****** ****** *)

// Prop Logic
  
fun make_and (
  _: !solver, _: List_vt(formula)
): formula = "mac#"

fun make_or (
  _: !solver, _: List_vt(formula)
): formula = "mac#"

fun make_not (
  _: !solver, _: formula
): formula = "mac#"

(* ****** ****** *)

// Arithmetic

fun make_numeral (
  _: !solver, _: string, _: sort
): formula = "mac#"

fun make_add (_: !solver, _: List_vt(formula)): formula = "mac#"

//only need two multiplications
fun make_mul (_: !solver, _: formula, _: formula): formula = "mac#"

fun make_lt (_: !solver, _: formula, _: formula): formula = "mac#"
fun make_le (_: !solver, _: formula, _: formula): formula = "mac#"
fun make_gt (_: !solver, _: formula, _: formula): formula = "mac#"
fun make_ge (_: !solver, _: formula, _: formula): formula = "mac#"
fun make_eq (_: !solver, _: formula, _: formula): formula = "mac#"

(* ****** ****** *)

// Solving

fun assert (_: !solver, _: formula): void = "mac#"

sortdef status = {a: int | a >= 0 ; a < 3}

#define UNSAT 0
#define SAT 1
#define UNKNOWN 2

fun check (_: !solver): [s: status] int s = "mac#"

(* ****** ****** *)

// Debugging (SMT-Lib)

fun string_of_formula (_: !solver, _: formula): string = "mac#"

(* ****** ****** *)
