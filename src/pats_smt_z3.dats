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

  extern
  fun Z3_mk_and {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_mk_or {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_mk_add {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_mk_mul {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_inc_ref (
    _: context, _: formula
  ): void = "mac#"

  extern
  fun Z3_dec_ref (
    _: context, _: formula
  ): void = "mac#"

  fun make_int_symbol (
    solve: !solver, id: int
  ): symbol = sym where {
    extern fun Z3_mk_int_symbol (
      _: context, _: int
    ): symbol = "mac#"
    //
    val sym = Z3_mk_int_symbol (solve.ctx, id)
  }
  
  (* ****** ****** *)

  typedef binop_func = {n:nat} (
    context, int n, &(@[formula][n])
  ) -> formula
  
  (*
    Z3 uses the same pattern for a few binary operators
  *)
  
  fun make_binop (
    solve: !solver, wffs: List_vt(formula), func: binop_func
  ): formula = res where {
    val len = list_vt_length (wffs)
    val ()  = assertloc(len >= 0)
    val len' = size1_of_int1 (len)  //need some shorthand, like (size)
    val (pf | p, free) = array_ptr_allocfree<formula> (len')
    val () = array_ptr_initialize_lst_vt<formula> (!p, wffs)
    //
    val res = func (solve.ctx, len, !p)
    val _ = Z3_inc_ref (solve.ctx, res)
    val () = clear_formulas(!p, len') where {
      fun clear_formulas {n:nat} (
        buf: &(@[formula][n]), sz: size_t n
      ):<cloref1> void = 
        loop(buf, 0) where {
        fun loop {i:nat | i <= n} (
          buf: &(@[formula][n]), i: size_t i
        ):<cloref1> void = 
          if i = sz then
            ()
          else let
            val fm = buf.[i]
            val _ = Z3_dec_ref(solve.ctx, fm)
          in loop(buf, i+1) end
      }
    }
    val () = free (pf | p)
    //
  }
in
  implement make_solver () = solve where {
    abstype tactic = ptr
    //  
    extern fun Z3_mk_config (): config = "mac#"
    extern fun Z3_mk_context_rc (_: config): context = "mac#"
    extern fun Z3_mk_solver_from_tactic (
      _: context, _: tactic
    ): (z3_solver) = "mac#"
    extern fun Z3_mk_solver (
      _: context
    ): z3_solver = "mac#"
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
    val conf = Z3_mk_config ()
    val ctx = Z3_mk_context_rc (conf)
    //
    val qflia = Z3_mk_tactic (ctx, "qflia")
    val _ = Z3_tactic_inc_ref (ctx, qflia)
    //
    val (z3solve) = Z3_mk_solver_from_tactic (ctx, qflia)
    val () = Z3_tactic_dec_ref(ctx, qflia)
    val solve = '{ctx= ctx, slv= z3solve}
  }
  
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
  
  implement make_int_sort (solve) = srt where {
    extern fun Z3_mk_int_sort (_: context): sort = "mac#"
    //
    val srt = Z3_mk_int_sort (solve.ctx)
  }
  
  implement make_constant (solve, id, srt) = cst where {
    extern fun Z3_mk_const (
      _: context, _: symbol, _: sort
    ): formula = "mac#"
    //
    val sym = make_int_symbol(solve, id)
    val cst = Z3_mk_const (solve.ctx, sym, srt)
    val _ = Z3_inc_ref(solve.ctx, cst)
  }
  
  (* ****** ****** *)
  
  implement make_not (solve, phi) = psi where {
    extern fun Z3_mk_not (_: context, _: formula): formula = "mac#"
    //
    val psi = Z3_mk_not (solve.ctx, phi)
    val _ = Z3_inc_ref (solve.ctx, psi)
  }
  
  implement make_or (solve, wffs) = 
    make_binop (solve, wffs, Z3_mk_or)
  
  implement make_and (solve, wffs) =
    make_binop (solve, wffs, Z3_mk_and)
  
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
  
  implement make_add (solve, wffs) = make_binop(solve, wffs, Z3_mk_add)
  
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
    val _ = Z3_inc_ref(solve.ctx, wff)    
  }
  
  (* ****** ****** *)
  
  implement assert (solve, formula) = {
    extern fun Z3_solver_assert (
      _: context, _: z3_solver, _: formula
    ): void = "mac#"
    //
    val _ = Z3_solver_assert(solve.ctx, solve.slv, formula)
    val _ = Z3_dec_ref(solve.ctx, formula)
  }
  
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