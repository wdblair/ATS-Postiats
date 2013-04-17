%{^
#include <z3.h>
%}

(* ****** ****** *)

absviewtype context

abstype symbol

abstype constant

absviewtype formula

abstype sort

(* ****** ****** *)

// Building Terms and Formulas

fun make_context (): context

fun delete_context(_: context): void

fun make_bool_sort (): sort = "mac#Z3_mk_bool_sort"
fun make_int_sort (): sort = "mac#Z3_mk_int_sort"

fun make_int_symbol (_: !context, _: int): symbol = "mac#Z3_mk_int_symbol"

fun make_constant (_: !context, _: symbol, _: sort): formula = "mac#Z3_mk_const"

fun copy_formula (_: !context, _: !formula): formula

fun del_formula (_: !context,  _: formula): void

(* ****** ****** *)

// Propositional Logic

fun make_true (_: !context): formula

fun make_false (_: !context): formula

fun make_eq (_: !context, _: formula, _:formula): formula

fun make_not(_: !context, _: formula): formula

fun make_ite(_: !context, _: formula, _: formula, _: formula): formula

fun make_implies(_: !context, _: formula, _:formula): formula

fun make_and (_: !context, _: formula, _: formula): formula
fun make_or (_: !context, _: formula, _: formula): formula

(* ****** ****** *)

// Arithmetic

fun make_add (_: !context, _: formula, _: formula): formula
fun make_sub (_: !context, _: formula, _: formula): formula
fun make_mul (_: !context, _: formula, _: formula): formula
fun make_div (_: !context, _: formula, _: formula): formula
fun make_unary_minus (_: !context, _: formula): formula

fun make_lt(_: !context, _: formula, _: formula): formula
fun make_le(_: !context, _: formula, _: formula): formula
fun make_gt(_: !context, _: formula, _: formula): formula
fun make_ge(_: !context, _: formula, _: formula): formula

fun is_int(_: !context, _: !formula): bool

(* ****** ****** *)

// Solving

fun assert(_: !context, _: !formula): void

sortdef status = {a: int | a >= 0 ; a < 3}

#define UNSAT 0
#define SAT 1
#define UNKNOWN 2

fun check(_: !context): [s: status] int s

(* ****** ****** *)