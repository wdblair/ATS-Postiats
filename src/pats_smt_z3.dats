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

staload "pats_smt.sats"
staload "pats_intinf.sats"

(* ****** ****** *)

staload "contrib/SMT/Z3/SATS/z3.sats"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

// A wrapper around Z3 for the constraint solver.

(* ****** ****** *)

viewtypedef solver_vtype = '{
  ctx= Z3_context,
  slv= Z3_solver
}

assume solver = solver_vtype

assume formula = Z3_ast
assume sort = Z3_sort

implement make_solver () = let
  val conf = Z3_mk_config ()
  val ctx = Z3_mk_context_rc (conf)
  val _ = Z3_del_config (conf)
  val solve = Z3_mk_solver (ctx)
in
  '{ctx= ctx, slv= solve}
end

implement delete_solver (solve) = {
    val _ = Z3_solver_dec_ref (solve.ctx, solve.slv)
    val _ = Z3_del_context (solve.ctx)
    prval _ = __free (solve) where {
      extern praxi __free{a:viewt@ype}(_: a): void
    }
}

implement make_int_sort (solve) =
  Z3_mk_int_sort(solve.ctx)

implement make_bool_sort (solve) =
  Z3_mk_bool_sort(solve.ctx)
  
implement make_int_constant (solve, id, sort) = let
  val sym = Z3_mk_int_symbol (solve.ctx, id)
in
  Z3_mk_const (solve.ctx, sym, sort)
end

implement make_true (solve) = Z3_mk_true(solve.ctx)

implement make_false (solve) = Z3_mk_false(solve.ctx)

implement make_not (solve, phi) = let
  val psi = Z3_mk_not(solve.ctx, phi)
  val _ = Z3_dec_ref(solve.ctx, phi)
in
  psi
end

implement make_ite (solve, cond, t, f) = let
  val ite = Z3_mk_ite(solve.ctx, cond, t, f)
  val () = begin
    Z3_dec_ref(solve.ctx, cond);
    Z3_dec_ref(solve.ctx, t);
    Z3_dec_ref(solve.ctx, f);
  end
in
  ite
end

implement make_or2 (solve, l, r) = let
  val phi = Z3_mk_or2(solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_and2 (solve, l, r) = let
  val phi = Z3_mk_and2(solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_numeral_int (solve, num, srt) =
  Z3_mk_int(solve.ctx, num, srt)

implement make_negate (solve, num) = let
  val neg = Z3_mk_unary_minus (solve.ctx, num)
  val () = begin
    Z3_dec_ref(solve.ctx, num)
  end
in
  neg
end

implement make_lt (solve, l, r) = let
  val phi = Z3_mk_lt (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_le (solve, l, r) = let
  val phi = Z3_mk_le (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_gt (solve, l, r) = let
  val phi = Z3_mk_gt (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_ge (solve, l , r) = let
  val phi = Z3_mk_ge (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_mul2 (solve, l, r) = let
  val phi = Z3_mk_mul2 (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_add2 (solve, l, r) = let
  val phi = Z3_mk_add2 (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_sub2 (solve, l, r) = let
  val phi = Z3_mk_sub2 (solve.ctx, l, r)
  val () = begin
    Z3_dec_ref(solve.ctx, l);
    Z3_dec_ref(solve.ctx, r);
  end
in
  phi
end

implement make_div (solve, num, den) = let
  val phi = Z3_mk_div (solve.ctx, num, den)
  val () = begin
    Z3_dec_ref(solve.ctx, num);
    Z3_dec_ref(solve.ctx, den);
  end
in
  phi
end

implement assert (solve, formula) = {
  val _ = Z3_solver_assert (solve.ctx, solve.slv, formula)
  val _ = Z3_dec_ref (solve.ctx, formula)
}

implement push (solve) = Z3_solver_push (solve.ctx, solve.slv)

implement pop (solve) = let
  val depth = Z3_solver_get_num_scopes (solve.ctx, solve.slv)
in
   if depth >  0u then
    Z3_solver_pop (solve.ctx, solve.slv, 1u)
end

macdef Z3_FALSE = $extval (Z3_lbool, "Z3_L_FALSE")
macdef Z3_TRUE  = $extval (Z3_lbool, "Z3_L_TRUE")

implement check (solve) = let
  val res = Z3_solver_check (solve.ctx, solve.slv)
in
  if res =  Z3_FALSE then
    ~1
  else
    0
end

(* ****** ****** *)

implement formula_dup (solve, wff) = Z3_inc_ref (solve.ctx, wff)

implement formula_free (solve, wff) = Z3_dec_ref (solve.ctx, wff)

implement sort_free (solve, srt) = Z3_sort_dec_ref (solve.ctx, srt)

(* ****** ****** *)

implement string_of_formula (solve, wff) =
  Z3_ast_to_string (solve.ctx, wff)
