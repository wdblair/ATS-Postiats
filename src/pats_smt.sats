%{#
#include <z3.h>
%}

(* ****** ****** *)

absviewtype context

abstype symbol

abstype constant

abstype formula

abstype sort

abstype solver

(* ****** ****** *)

// Building Terms and Formulas

fun make_context (): context = "mac#"

fun del_context(_: context): void = "mac#Z3_del_context"

fun make_bool_sort (): sort = "mac#Z3_mk_bool_sort"
fun make_int_sort (): sort = "mac#Z3_mk_int_sort"

fun make_int_symbol (
  _: !context, _: int
): symbol = "mac#Z3_mk_int_symbol"

fun make_constant (
  _: !context, _: symbol, _: sort
): formula = "mac#Z3_mk_const"

(*
   I have a feeling that when I delete the
   context, all the formulas will be freed.
   Of course, I should figure out how to a
   do this properly, but the current API
   doesn't seem to support retrieving sub
   formulas.
*)

(* ****** ****** *)

fun make_and {n:nat} (
  _: !context, _: List(formula)
): formula

fun make_or {n:nat} (
  _: !context, _: List(formula)
): formula

(* ****** ****** *)

// Arithmetic

fun make_add (_: !context, _: List(formula)): formula
fun make_mul (_: !context, _: List(formula)): formula
fun make_unary_minus (_: !context, _: formula): formula

fun make_lt (_: !context, _: formula, _: formula): formula
fun make_le (_: !context, _: formula, _: formula): formula
fun make_gt (_: !context, _: formula, _: formula): formula
fun make_ge (_: !context, _: formula, _: formula): formula

(* ****** ****** *)

// Solving

fun assert (_: !context, _: solver, _: formula): void

sortdef status = {a: int | a >= 0 ; a < 3}


#define UNSAT 0
#define SAT 1
#define UNKNOWN 2

fun check (_: !context, _: solver): [s: status] int s

(* ****** ****** *)