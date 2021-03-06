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

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "solving/smt.sats"
staload "solving/smt_ML.sats"

(* ****** ****** *)

staload "contrib/SMT/Z3/SATS/z3.sats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

assume solver = Z3_solver

assume formula = Z3_ast
assume func_decl = Z3_func_decl
assume sort = Z3_sort

local
  var ctx : Z3_context
  
  val conf = Z3_mk_config ()
  val () = ctx := Z3_mk_context_rc (conf)
  
  val () = Z3_del_config (conf)
in
  val the_context = ref_make_viewptr{Z3_context} (view@ ctx | addr@ ctx)
end

(* ****** ****** *)

local
  var slv: solver
  
  val () = slv := Z3_mk_solver (!the_context)
in
  val the_solver = ref_make_viewptr{solver} (view@ slv | addr@ slv)
end

(* ****** ****** *)

implement
the_solver_get () = let
  val (pf, fpf | p ) = $UN.ref_vtake{solver} (the_solver)
  val new = Z3_solver_inc_ref (!the_context, !p)
  prval () = fpf (pf)
in
  new
end // end of [the_solver_get]

implement 
make_solver () = let
  val solve = the_solver_get ()
in
  solve
end // end of [make_solver]

implement 
delete_solver (solve) = {
  val _ = Z3_solver_dec_ref (!the_context, solve)
} // end of [delete_solver]

implement 
make_int_sort () =
  Z3_mk_int_sort (!the_context)

implement 
make_bool_sort () =
  Z3_mk_bool_sort (!the_context)

implement
make_real_sort () = 
  Z3_mk_real_sort (!the_context)

implement 
make_bitvec_sort (width) =
  Z3_mk_bv_sort (!the_context, g0int2uint(width))

implement
make_array_sort () = let
  val int  = Z3_mk_int_sort (!the_context)
  val int' = Z3_sort_inc_ref (!the_context, int)
  val array = Z3_mk_array_sort (!the_context, int, int')
in
  Z3_sort_dec_ref (!the_context, int);
  Z3_sort_dec_ref (!the_context, int');
  array
end

implement
make_abstract_sort (name) = let
  val sym = Z3_mk_string_symbol (!the_context, name)
in
  Z3_mk_uninterpreted_sort (!the_context, sym)
end

implement 
make_int_constant (id, sort) = let
  val sym = Z3_mk_int_symbol (!the_context, id)
in
  Z3_mk_const (!the_context, sym, sort)
end

implement 
make_fresh_constant (sort) =
    Z3_mk_fresh_const (!the_context, "postiats", sort)

implement
make_func_decl (name, domain, range) = let
  val sym = Z3_mk_string_symbol (!the_context, name)
  //
  val n = g1int2uint (length (domain))
  val (pf, gc | p) = array_ptr_alloc<sort> (u2sz (n))
  val () = array_copy_from_list_vt<sort> (!p, domain)
  //  
  val decl = Z3_mk_func_decl (!the_context, sym, n, !p, range)
  //
  implement array_uninitize$clear<sort> (i, srt) = {
    val () = Z3_sort_dec_ref (!the_context, srt)
  }
in
  array_uninitize<sort> (!p, u2sz(n));
  array_ptr_free{sort} (pf, gc | p);
  Z3_sort_dec_ref (!the_context, range);
  decl
end

implement
make_app (f, args) = let
  val n = g1int2uint (length (args))
  val (pf, gc | p) = array_ptr_alloc<formula> (u2sz (n))
  val () = array_copy_from_list_vt<formula> (!p, args)
  val app = Z3_mk_app (!the_context, f, n, !p)
  //
  implement
  array_uninitize$clear<formula> (i, f) = {
    val () = Z3_dec_ref (!the_context, f)
  }
in
  array_uninitize<formula> (!p, u2sz (n));
  array_ptr_free{formula} (pf, gc | p);
  app
end

implement 
make_true () = Z3_mk_true (!the_context)

implement 
make_false () = Z3_mk_false (!the_context)

implement 
make_not (phi) = let
  val psi = Z3_mk_not (!the_context, phi)
  val _ = Z3_dec_ref (!the_context, phi)
in
  psi
end

implement 
make_ite (cond, t, f) = let
  val ite = Z3_mk_ite (!the_context, cond, t, f)
  val () = begin
    Z3_dec_ref (!the_context, cond);
    Z3_dec_ref (!the_context, t);
    Z3_dec_ref (!the_context, f);
  end
in
  ite
end

implement 
make_or2 (l, r) = let
  val phi = Z3_mk_or2 (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  phi
end

implement 
make_and2 (l, r) = let
  val phi = Z3_mk_and2 (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  phi
end

implement
make_implies (l, r) = let
  val phi = Z3_mk_implies (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  phi
end

implement 
make_eq (l, r) = let
  val phi = Z3_mk_eq (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  phi
end

implement 
make_numeral_int (num, srt) =
  Z3_mk_int (!the_context, num, srt)
  
implement 
make_numeral_string (num, srt) =
  Z3_mk_numeral (!the_context, num, srt)

implement 
make_numeral_uninterpreted (srt) = let
in
  Z3_mk_fresh_const (!the_context, "uninterp", srt)
end

implement 
make_negate (num) = let
  val neg = Z3_mk_unary_minus (!the_context, num)
  val () = begin
    Z3_dec_ref (!the_context, num)
  end
in
  neg
end

implement 
make_lt (l, r) = let
  val phi = Z3_mk_lt (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  phi
end

implement 
make_le (l, r) = let
  val phi = Z3_mk_le (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement 
make_gt (l, r) = let
  val phi = Z3_mk_gt (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement 
make_ge (l , r) = let
  val phi = Z3_mk_ge (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement
make_mul2 (l, r) = let
  val phi = Z3_mk_mul2 (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement 
make_add2 (l, r) = let
  val phi = Z3_mk_add2 (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement 
make_sub2 (l, r) = let
  val phi = Z3_mk_sub2 (!the_context, l, r)
  val () = begin
    Z3_dec_ref(!the_context, l);
    Z3_dec_ref(!the_context, r);
  end
in
  phi
end

implement 
make_div (num, den) = let
  val phi = Z3_mk_div (!the_context, num, den)
  val () = begin
    Z3_dec_ref(!the_context, num);
    Z3_dec_ref(!the_context, den);
  end
in
  phi
end

implement
is_int (num) = let
  val phi = Z3_mk_is_int (!the_context, num)
  val () = begin
    Z3_dec_ref(!the_context, num);
  end
in
  phi
end

(* ****** ****** *)

implement
make_bv_sub2 (l, r) = let
  val dif = Z3_mk_bvsub (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  dif
end

implement
make_bv_add2 (l, r) = let
  val sum = Z3_mk_bvadd (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  sum
end

implement
make_bv_land2 (l, r) = let
  val masked = Z3_mk_bvand (!the_context, l, r)
  val () = begin
    Z3_dec_ref (!the_context, l);
    Z3_dec_ref (!the_context, r);
  end
in
  masked
end

implement
make_bv_eq (l, r) = make_eq (l, r)

implement
make_bv_from_int (n, i) = let
  val bv = Z3_mk_int2bv (!the_context, n, i)
  val () = begin
    Z3_dec_ref (!the_context, i)
  end
in
  bv
end

(* ****** ****** *)

implement
make_real_from_int (i) = let
  val q = Z3_mk_int2real (!the_context, i)
  val () = begin
    Z3_dec_ref (!the_context, i)
  end
in
  q
end

(* ****** ****** *)

implement 
assert (solve, formula) = {
  val _ = Z3_solver_assert (!the_context, solve, formula)
  val _ = Z3_dec_ref (!the_context, formula)
}

implement 
push (solve) = Z3_solver_push (!the_context, solve)

implement 
pop (solve) = let
  val depth = Z3_solver_get_num_scopes (!the_context, solve)
in
   if depth > 0u then
    Z3_solver_pop (!the_context, solve, 1u)
end

macdef Z3_FALSE = $extval (Z3_lbool, "Z3_L_FALSE")
macdef Z3_TRUE  = $extval (Z3_lbool, "Z3_L_TRUE")

implement 
is_valid (solve, formula) = let
  val () = push (solve)
  //
  val neg = make_not (formula)
  val () = assert (solve, neg)
  val sat = Z3_solver_check (!the_context, solve)
  //
  val () = pop (solve)
in
  if sat = Z3_FALSE then
    true
  else
    false
end

(* ****** ****** *)

implement 
formula_dup (wff) = Z3_inc_ref (!the_context, wff)

implement 
formula_free (wff) = Z3_dec_ref (!the_context, wff)

implement 
sort_free (srt) = Z3_sort_dec_ref (!the_context, srt)

implement
func_decl_dup (dec) = Z3_func_decl_inc_ref (!the_context, dec)

implement
func_decl_free (dec) = Z3_func_decl_dec_ref (!the_context, dec)

(* ****** ****** *)

implement 
string_of_formula (wff) =
  Z3_ast_to_string (!the_context, wff)
  
(* ****** ****** *)

(* ML interface *)

implement
int_constant_name (label) = let
  val sym = Z3_mk_string_symbol (!the_context, label)
  val ty = Z3_mk_int_sort (!the_context)
  val const = Z3_mk_const (!the_context, sym, ty)
in
  Z3_sort_dec_ref (!the_context, ty);
  const
end

implement
int_numeral (i) = let
  val ty = Z3_mk_int_sort (!the_context)
  val i = Z3_mk_int (!the_context, i, ty)
in
  Z3_sort_dec_ref (!the_context, ty);
  i
end

implement
bool_constant_name (b) = let
  val sym = Z3_mk_string_symbol (!the_context, b)
  val ty = Z3_mk_bool_sort (!the_context)
  val const = Z3_mk_const (!the_context, sym, ty)
in
  Z3_sort_dec_ref (!the_context, ty);
  const
end

implement
bool_bool (b) =
  if b then 
    Z3_mk_true (!the_context)
  else 
    Z3_mk_false (!the_context)
    
local
  val null = the_null_ptr
  
  implement array_uninitize$clear<Z3_app> (i, x) = {
    val ast = Z3_ast_from_app (x)
    val () = Z3_dec_ref (!the_context, ast)
  }
in   
 
implement
forall1 (v, body) = let
  var bound = @[Z3_app](Z3_app_from_ast (v))
  val forall =
    Z3_mk_forall_const (!the_context, 0u, 1u, bound,  0u, null, body)
in
  array_uninitize<Z3_app> (bound, u2sz(1u));
  Z3_dec_ref (!the_context, body);
  forall
end

implement
forall2 (x, y, body) = let
  var bound = @[Z3_app](Z3_app_from_ast (x), Z3_app_from_ast (y))
  val forall =
    Z3_mk_forall_const (!the_context, 0u, 2u, bound,  0u, null, body)
in
  array_uninitize<Z3_app> (bound, u2sz(2u));
  Z3_dec_ref (!the_context, body);
  forall
end

end // end of [local]

(* ****** ****** *)

(* I think I'd like to get rid of the make_* functions... *)

implement And (f0, f1) = make_and2 (f0, f1)
implement Or (f0, f1) = make_or2 (f0, f1)
implement Not (f0) = make_not (f0)
implement Implies (f0, f1) = make_implies (f0, f1)
implement If (f0, f1, f2) = make_ite (f0, f1, f2)

implement add_formula_formula (f0, f1) = make_add2 (f0, f1)
implement sub_formula_formula (f0, f1) = make_sub2 (f0, f1)
implement mul_formula_formula (f0, f1) = make_mul2 (f0, f1)
implement div_formula_formula (f0, f1) = make_div (f0, f1)
implement neg_formula (f0) = make_negate (f0)

implement gt_formula_formula (f0, f1) = make_gt (f0, f1)
implement gte_formula_formula (f0, f1) = make_ge (f0, f1)
implement eq_formula_formula (f0, f1) = make_eq (f0, f1)
implement lte_formula_formula (f0, f1) = make_le (f0, f1)
implement lt_formula_formula (f0, f1) = make_lt (f0, f1)

(* ****** ****** *)

implement
Select (a, i) = let
  val sel = Z3_mk_select (!the_context, a, i)
in
  Z3_dec_ref (!the_context, a);
  Z3_dec_ref (!the_context, i);
  sel
end

implement
Store (a, i, v) = let
  val store = Z3_mk_store (!the_context, a, i, v)
in
  Z3_dec_ref (!the_context, a);
  Z3_dec_ref (!the_context, i);
  Z3_dec_ref (!the_context, v);
  store
end

(* ****** ****** *)

implement
parse_smtlib2_file (file, ds) = let
  vtypedef keyval = @(string, func_decl)
  val n = g1int2uint (length (ds))
  //
  implement 
  list_vt_map$fopr<keyval><Z3_symbol> (x) = let
    val sym = Z3_mk_string_symbol (!the_context, x.0)
  in
    sym
  end
  //
  val names = list_vt_map<keyval><Z3_symbol> (ds)
  //
  implement
  list_vt_mapfree$fopr<keyval><func_decl> (x) = x.1
  //
  val decls = list_vt_mapfree<keyval><func_decl> (ds)
  //
  val (nm_pf, nm_gc | nm) = array_ptr_alloc<Z3_symbol> (u2sz (n))
  val (de_pf, de_gc | de) = array_ptr_alloc<func_decl> (u2sz (n))
  //
  val () = array_copy_from_list_vt (!nm, names)
  val () = array_copy_from_list_vt (!de, decls)
  //
  val null = the_null_ptr
  val conj = Z3_parse_smtlib2_file
    (!the_context, file, 0u, null, null, n, !nm, !de)
  //
  implement
  array_uninitize$clear<func_decl> (i, dec) =
    Z3_func_decl_dec_ref (!the_context, dec)
  //
in
  array_uninitize<func_decl> (!de, u2sz (n));
  array_ptr_free (nm_pf, nm_gc | nm);
  array_ptr_free (de_pf, de_gc | de);
  conj
end