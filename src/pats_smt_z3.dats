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

staload _ = "prelude/DATS/list_vt.dats"
staload _ = "prelude/DATS/array.dats"
staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

// A simple wrapper around Z3 for the constraint solver.

(* ****** ****** *)

abstype config = ptr
abstype context = ptr
abstype symbol = ptr
abstype z3_solver = ptr

assume solver = '{
  ctx= context,
  slv= z3_solver
}

local

in
  implement make_solver () = solve where {
    abstype tactic = ptr
    abstype probe = ptr
    //  
    extern fun Z3_mk_config (): config = "mac#"
    extern fun Z3_mk_context_rc (_: config): context = "mac#"
    extern fun Z3_mk_solver_from_tactic (
      _: context, _: tactic
    ): (z3_solver) = "mac#"
    extern fun Z3_mk_solver (
      _: context
    ): z3_solver = "mac#"
    extern fun Z3_solver_inc_ref (_: context, _: z3_solver): void = "mac#"
    //
    extern fun Z3_mk_tactic (_: context, _: string): tactic = "mac#"
    extern fun Z3_tactic_inc_ref (_: context, _: tactic): void = "mac#"
    extern fun Z3_tactic_dec_ref (_: context, _: tactic): void = "mac#"
    extern fun Z3_tactic_and_then (
      _: context, _: tactic, _:tactic
    ): tactic = "mac#"
    extern fun Z3_tactic_or_else (
      _: context, _: tactic, _: tactic
    ): tactic = "mac#"
    //
    extern fun Z3_mk_probe (_: context, _: string): probe = "mac#"
    extern fun Z3_probe_inc_ref (_: context, _: probe): void = "mac#"
    //
    extern fun  Z3_tactic_cond (
      _: context, _: probe, _: tactic, _: tactic
    ): tactic = "mac#"
    //
    val conf = Z3_mk_config ()
    val ctx = Z3_mk_context_rc (conf)
    //
    val qe = Z3_mk_tactic (ctx, "qe")
    val _ = Z3_tactic_inc_ref (ctx, qe)
    // 
    val nlsat = Z3_mk_tactic (ctx, "nlsat")
    val _ = Z3_tactic_inc_ref (ctx, nlsat)
    //
    val qfnia = Z3_mk_tactic (ctx, "qfnia")
    val _ = Z3_tactic_inc_ref (ctx, qfnia)
    //    
    val faster_nonlin = Z3_tactic_and_then (ctx, qe, nlsat)
    val _ = Z3_tactic_inc_ref (ctx, faster_nonlin)
    //
    val nonlinear = Z3_tactic_or_else (ctx, faster_nonlin, qfnia)
    val _ = Z3_tactic_inc_ref (ctx, nonlinear)
    //
    val linear = Z3_mk_tactic (ctx, "qflia")
    val _ = Z3_tactic_inc_ref (ctx, linear)
    //
    val is_qflia = Z3_mk_probe (ctx, "is-qflia")
    val _ = Z3_probe_inc_ref (ctx, is_qflia)
    //
    val strategy = Z3_tactic_cond (ctx, is_qflia, linear, nonlinear)
    val _ = Z3_tactic_inc_ref (ctx, strategy)
    //
    //val (z3solve) = Z3_mk_solver_from_tactic (ctx, strategy)
    val z3solve = Z3_mk_solver(ctx)
    val _ = Z3_solver_inc_ref(ctx, z3solve)
//    val () = Z3_tactic_dec_ref (ctx, strategy)
    val solve = '{ctx= ctx, slv= z3solve}
  }
  
  (* ****** ****** *)
  
  implement delete_solver (solve) = {
    extern fun Z3_del_context (_: context): void = "mac#"
    extern fun Z3_solver_dec_ref (_: context, _: z3_solver): void = "mac#"
    //
    val () = Z3_solver_dec_ref(solve.ctx, solve.slv)
    val () = Z3_del_context(solve.ctx)
    prval _ = __free(solve) where {
      extern
      praxi __free (_: solver): void
    }
  }
  
  extern fun Z3_sort_to_ast (_: context, _: sort): formula = "mac#"
  
  implement make_int_sort (solve) = srt where {
    extern fun Z3_mk_int_sort (_: context): sort = "mac#"
    //
    val srt = Z3_mk_int_sort (solve.ctx)
    val fm = Z3_sort_to_ast (solve.ctx, srt)
    val _ = Z3_inc_ref (solve.ctx, fm)
  }
  
  implement make_bool_sort (solve) = srt where {
    extern fun Z3_mk_bool_sort (_: context): sort = "mac#"
    //
    val srt = Z3_mk_bool_sort (solve.ctx)
    val fm = Z3_sort_to_ast (solve.ctx, srt)
    val _ = Z3_inc_ref (solve.ctx, fm)
  }
  
<<<<<<< HEAD
  implement make_int_constant (solve, id, srt) = cst where {
=======
  implement make_bool_sort (solve) = srt where {
    extern fun Z3_mk_bool_sort (_: context): sort = "mac#"
    //
    val srt = Z3_mk_bool_sort (solve.ctx)
  }
  
  implement make_constant (solve, id, srt) = cst where {
>>>>>>> Got the constraint solver shell working (doesn't solve anything yet).
    extern fun Z3_mk_const (
      _: context, _: symbol, _: sort
    ): formula = "mac#"
    //
    val sym = make_int_symbol (solve, id)
    val cst = Z3_mk_const (solve.ctx, sym, srt)
    val _ = Z3_inc_ref (solve.ctx, cst)
  }
  
  implement make_fresh_constant (solve, srt) = cst where {
    extern fun Z3_mk_fresh_const (
      _: context, _: string, _: sort
    ): formula = "mac#"  
    //
    val cst = Z3_mk_fresh_const (solve.ctx, "cnstr", srt)
    val _ = Z3_inc_ref (solve.ctx, cst)
  }
  
  (* ****** ****** *)
  
  implement make_true (solve) = wff where {
    extern fun Z3_mk_true (_: context): formula = "mac#"
    //
    val wff = Z3_mk_true (solve.ctx)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }

  implement make_false (solve) = wff where {
    extern fun Z3_mk_false (_: context): formula = "mac#"
    //
    val wff = Z3_mk_false (solve.ctx)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }
  
  implement make_not (solve, phi) = psi where {
    extern fun Z3_mk_not (_: context, _: formula): formula = "mac#"
    //
    val psi = Z3_mk_not (solve.ctx, phi)
    val _ = Z3_inc_ref (solve.ctx, psi)
  }
  
  implement make_ite (solve, cond, t, f) = wff where {
    extern fun Z3_mk_ite (
      _: context, _: formula, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_ite (solve.ctx, cond, t, f)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }
    
  implement make_or2 (solve, l, r) = wff where {
    var !args = @[formula][2](l)
    val () = !args.[0] := l
    val () = !args.[1] := r
    val wff = Z3_mk_or (solve.ctx, 2, !args)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }
   
  implement make_and2 (solve, l, r) = wff where {
    var !args = @[formula][2](l)
    val () = !args.[0] := l
    val () = !args.[1] := r
    val wff = Z3_mk_and (solve.ctx, 2, !args)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }
  
  (* ****** ****** *)
    
  implement make_numeral_intinf (solve, n, srt) = num where {
    extern fun Z3_mk_numeral (
      _: context, _: string, _: sort
    ): formula = "mac#"
    //
    val str = intinf_get_string (n)
    //
    val num = Z3_mk_numeral (solve.ctx, str, srt)
  }
  
  implement make_numeral_int (solver, num, srt) = wff where {
    extern fun Z3_mk_int (_: context, _: int, _: sort): formula = "mac#"
    val wff = Z3_mk_int(solver.ctx, num, srt)
    val _ = Z3_inc_ref(solver.ctx, wff)
  }
  
  implement make_negate (solver, num) = wff where {
    extern fun Z3_mk_unary_minus (_: context, _: formula): formula = "mac#"
    //
    val wff = Z3_mk_unary_minus (solver.ctx, num)
    val _   = Z3_inc_ref (solver.ctx, wff)
  }
  
  implement make_lt (solve, l, r) = wff where {
    extern fun Z3_mk_lt (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_lt (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_le (solve, l, r) = wff where {
    extern fun Z3_mk_le (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_le (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_gt (solve, l, r) = wff where {
    extern fun Z3_mk_gt (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_gt (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_ge (solve, l, r) = wff where {
    extern fun Z3_mk_ge (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_ge (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_eq (solve, l, r) = wff where {
    extern fun Z3_mk_eq (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_eq (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }
  
  implement make_mul2 (solve, l, r) = wff where {
    var !args = @[formula][2](l)
    val () = !args.[0] := l
    val () = !args.[1] := r
    val wff = Z3_mk_mul (solve.ctx, 2, !args)
<<<<<<< HEAD
<<<<<<< HEAD
    val _ = Z3_inc_ref (solve.ctx, wff)
  }

  implement make_add2 (solve, l, r) = wff where {
    var !args = @[formula][2](l)
    val () = !args.[0] := l
    val () = !args.[1] := r
    val wff = Z3_mk_add (solve.ctx, 2, !args)
    val _ = Z3_inc_ref (solve.ctx, wff)
  }

  implement make_sub2 (solve, l, r) = wff where {
    var !args = @[formula][2](l)
    val () = !args.[0] := l
    val () = !args.[1] := r
    val wff = Z3_mk_sub (solve.ctx, 2, !args)
    val _ = Z3_inc_ref (solve.ctx, wff)
=======
    val _ = Z3_inc_ref(solve.ctx, wff)    
>>>>>>> Removed most of the current constraint solver, starting with just s2 expressions.
=======
    val _ = Z3_inc_ref (solve.ctx, wff)
>>>>>>> Got the constraint solver shell working (doesn't solve anything yet).
  }
  
  implement make_div (solve, num, den) = wff where {
    extern fun Z3_mk_div (
      _: !context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_div (solve.ctx, num, den)
    val _   = Z3_inc_ref (solve.ctx, wff)
  }
 
  (* ****** ****** *)
  
  implement assert (solve, formula) = {
    extern fun Z3_solver_assert (
      _: context, _: z3_solver, _: formula
    ): void = "mac#"
    //
    val _ = Z3_solver_assert (solve.ctx, solve.slv, formula)
    val _ = Z3_dec_ref (solve.ctx, formula)
  }
  
  implement push (solve) = let
    extern fun Z3_solver_push (
      _: context, _: z3_solver
    ): void = "mac#"
    //
<<<<<<< HEAD
    val _ = println!(Z3_solver_get_num_scopes (solve.ctx, solve.slv))
=======
>>>>>>> Got the constraint solver shell working (doesn't solve anything yet).
  in
    Z3_solver_push (solve.ctx, solve.slv)
  end
  
  implement pop (solve) = let
    extern fun Z3_solver_pop (
      _: context, _: z3_solver, _: uint
    ): void = "mac#"
  in
<<<<<<< HEAD
    if Z3_solver_get_num_scopes(solve.ctx, solve.slv) > 0u then
      Z3_solver_pop (solve.ctx, solve.slv, 1u)
=======
    Z3_solver_pop (solve.ctx, solve.slv, 1u)
>>>>>>> Got the constraint solver shell working (doesn't solve anything yet).
  end
  
  macdef Z3_FALSE = $extval(int, "Z3_L_FALSE")
  macdef Z3_TRUE = $extval(int, "Z3_L_TRUE")
  
  implement check (solver) = let
    extern fun Z3_solver_check (
      _: context, _: z3_solver
    ): [s:status] int s = "mac#"
    //
    val res = Z3_solver_check (solver.ctx, solver.slv)
  in
    case+ res of 
      | _ when res = Z3_FALSE => ~1
      | _ when res = Z3_TRUE => 0
      | _ =>> 0 //unknown might as well mean invalid
  end
  
  (* ****** ****** *)
  
  implement string_of_formula (solver, wff) = expr where {
    extern fun Z3_ast_to_string (
      _: context, _: formula
    ): string = "mac#"
    //
    val expr = Z3_ast_to_string (solver.ctx, wff)
  }
end
