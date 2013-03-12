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
// Author: Will Blair (wdblair AT cs DOT bu DOT edu)
// Start Time: May, 2013
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload SMT = "./pats_smt.sats"

viewtypedef solver = $SMT.solver
viewtypedef formula = $SMT.formula

viewtypedef sort = $SMT.sort

(* ****** ****** *)

staload "./pats_stamp.sats"

(* ****** ****** *)

staload "./pats_error.sats"

(* ****** ****** *)

staload "./pats_error.sats"

(* ****** ****** *)

val log_smt = false

(* ****** ****** *)

local
  staload LM = "libats/SATS/linmap_avltree.sats"
  staload _(*anon*) = "libats/DATS/linmap_avltree.dats"
  
  staload FM = "libats/SATS/funmap_avltree.sats"
  staload _(*anon*) = "libats/DATS/funmap_avltree.dats"
  
  typedef substitution = @(s3ubexp, s2var)
  
  fn cmp (
    x1: s2var, x2: s2var
  ) :<cloref> int = compare_s2var_s2var (x1, x2)
  
  viewtypedef smtenv_struct = @{
    smt= solver,
    variables= @{
      (* 
        Map static variables to their respective SMT formulas
      *)
      static= $LM.map(s2var, formula),
      (*
        I should keep s3exp if only to make this field more accessible
        for other purposes.
      *)
      substitutes= List_vt(substitution)
    },
    sorts = @{
      integer= sort,
      boolean= sort
    },
    err= int 
  }
  
  assume smtenv_viewtype = smtenv_struct

in
  implement smtenv_nil (env) = begin
    env.smt := $SMT.make_solver ();
    env.variables.static := $LM.linmap_make_nil ();
    env.variables.substitutes := list_vt_nil();
    env.sorts.integer := $SMT.make_int_sort (env.smt);
    env.sorts.boolean := $SMT.make_bool_sort (env.smt);
    env.err := 0;
  end
  
  implement smtenv_free (env) = let
   val static = $LM.linmap_listize_free (env.variables.static)
   //
   viewtypedef binding = @(s2var, formula)
   //
   fun release_vars (slv: !solver, vs: List_vt(binding)): void = 
    case+ vs of 
      | ~list_vt_nil () => ()
      | ~list_vt_cons (@(_, v), vss) => let
        val _ = $SMT.formula_free(slv, v)
      in 
        release_vars (slv, vss)
      end
   //
   in begin
      release_vars (env.smt, static);
      list_vt_free(env.variables.substitutes);
      $SMT.sort_free (env.smt, env.sorts.integer);
      $SMT.sort_free (env.smt, env.sorts.boolean);
      $SMT.delete_solver (env.smt);
     end
   end
  
  implement formula_from_substitution (env, s3ub) = let
    val srt = s3ubexp_get_srt (s3ub)
    val opt = smtenv_find_substitution (env, s3ub)
  in 
    case+ opt of 
      | Some (s2v) => smtenv_get_var_exn (env, s2v)
      | None () => let
        val s2v = s2var_make_srt (srt)
        val _ = smtenv_make_substitution (env, s3ub, s2v)
        val _ = smtenv_add_svar (env, s2v)
       in
        smtenv_get_var_exn(env, s2v)
       end
  end
  
  implement smtenv_find_substitution (env, sub) = let
    fun find_loop (
      xs: &List_vt(substitution), needle: s3ubexp
    ): Option(s2var) =
      case+ xs of
        | list_vt_cons(@(s3ub, s2v), !xss) =>
          if s3ubexp_syneq (needle, s3ub) then let
            val _ = fold@(xs)
           in Some(s2v) end
          else let
            val opt = find_loop(!xss, needle)
            val _ = fold@(xs)
          in opt end
        | list_vt_nil() => let
          val () = fold@(xs)
        in None() end
    //
  in
    find_loop(env.variables.substitutes, sub)
  end
   
  implement smtenv_make_substitution (env, sub, s2v) = 
    env.variables.substitutes := list_vt_cons(@(sub, s2v), env.variables.substitutes)
    
  implement smtenv_push (env) = (pf | ()) where {
    val _ = if log_smt then println! ("(push 1)")
    val _ = $SMT.push (env.smt)
    prval pf = __push () where {
      extern praxi __push (): smtenv_push_v
    }
  }
  
  implement smtenv_pop (pf | env) = {
    val _ = if log_smt then println! ("(pop 1)")
    val _ = $SMT.pop (env.smt)
    prval _ = __pop (pf) where {
      extern praxi __pop (pf: smtenv_push_v): void
    }
  }
  
  implement smtenv_add_svar (env, s2v) = {
    val type = s2var_get_srt (s2v)
    var is_int : bool
    val smt_type = (
      if s2rt_is_int (type) orelse s2rt_is_addr (type)
        orelse s2rt_is_char (type) then let
        val _ = is_int := true
      in
         $SMT.make_int_sort (env.smt)
      end
      else let 
        val _ = is_int := false
      in
        $SMT.make_bool_sort (env.smt)
      end
    ): $SMT.sort
    val stamp = s2var_get_stamp (s2v)
    val id = stamp_get_int (stamp)
    val _ = if log_smt then println! ("Variables: ", $LM.linmap_size(env.variables.static))
    //
    val label = if is_int then "Int" else "Bool"
    val _ = if log_smt then println! ("(declare-fun k!", id, " () ", label, ")")
    //
    val fresh = $SMT.make_int_constant (env.smt, id, smt_type)
    var res: formula?
    val found = $LM.linmap_insert (env.variables.static, s2v, fresh, cmp, res)
    val () =
      if found then let
        prval () = opt_unsome {formula} (res)
      in
        $SMT.formula_free(env.smt, res)
      end
      else {
        prval () = opt_unnone {formula} (res)
      }
    val () = $SMT.sort_free(env.smt, smt_type)
  }
  
  implement smtenv_get_var_exn (env, s2v) = let
    val [l:addr] ptr = $LM.linmap_search_ref (env.variables.static, s2v, cmp)
  in
    if ptr = null then
      abort () where {
        val _ = prerrln! ("SMT formula not found for s2var: ", s2v)
      }
    else let
      prval (free, pf) = __assert () where {
        extern praxi __assert (): (formula @ l -<prf> void, formula @ l)
      }
      val variable = $SMT.formula_dup(env.smt, !ptr)
      prval () = free(pf)
    in
      variable
    end
  end

  (* ****** ****** *)
  
  implement formula_make (env, s2e) = let
    val s2e = s2exp_hnfize_smt (s2e)
  in
    case+ s2e.s2exp_node of
      | S2Eint i =>
        $SMT.make_numeral (env.smt, i, env.sorts.integer)
      //
      | S2Eintinf i =>
        $SMT.make_numeral (env.smt, i, env.sorts.integer)
      //
      | S2Evar s2v => smtenv_get_var_exn (env, s2v)
      | S2Ecst s2c => (case+ s2c of
        | _ when
            s2cstref_equ_cst (the_null_addr, s2c) =>
              $SMT.make_numeral (env.smt, 0, env.sorts.integer)
        //
        | _ when
            s2cstref_equ_cst (the_true_bool, s2c) =>
              $SMT.make_true (env.smt)
        | _ when
            s2cstref_equ_cst (the_false_bool, s2c) =>
              $SMT.make_false (env.smt)
        | _ => let
          val srt = s2cst_get_srt (s2c)
          val stamp = s2cst_get_stamp (s2c)
          val id    = stamp_get_int (stamp)
        in
           if s2rt_is_int (srt) orelse s2rt_is_addr (srt) then
            $SMT.make_int_constant (env.smt, id, env.sorts.integer)
           else if s2rt_is_bool (srt) then let
            in $SMT.make_int_constant (env.smt, id, env.sorts.boolean) end
           else let
              val s3ub = s3ubexp_cst (s2c)
           in 
              formula_from_substitution (env, s3ub)
           end        
        end
      )
      | S2Eeqeq (l, r) => let
        val lhs = formula_make (env, l)
        val rhs = formula_make (env, r)
      in
        $SMT.make_eq (env.smt, lhs, rhs)
      end
      | S2Eapp
          (s2e1, s2es2) => (
            case+ s2e1.s2exp_node of
              | S2Ecst s2c1 =>
                formula_make_s2cst_s2explst (env, s2c1, s2es2)
              //
              | _ => abort () where {
                val _ = prerrln! ("formula_make: Invalid application ", s2e)
              }
          ) // end of [S2Eapp]
      | S2Emetdec (met, met_bound) => let
        val s2e_met = s2exp_metdec_reduce (met, met_bound)
      in
        formula_make (env, s2e_met)
      end // end of [S3Emetdec]
      | S2Esizeof (s2exp) => let
        val s2ze = s2zexp_make_s2exp (s2exp)
        val s3ub = s3ubexp_sizeof (s2ze)
      in
        formula_from_substitution (env, s3ub)
      end
      | _ => let
        val srt = s2e.s2exp_srt
        val stub = (
            if s2rt_is_int (srt) orelse s2rt_is_addr (srt)
                orelse s2rt_is_char (srt) then
              $SMT.make_fresh_constant (env.smt, env.sorts.integer)
            else 
              $SMT.make_fresh_constant (env.smt, env.sorts.boolean)
        ): formula
        (* TODO: Make this error mean something to calling functions *)
        val _ = env.err := env.err + 1
        val _ = prerrln! ("warning(3): s3exp_make_s2exp: s2e =:", s2e)
      in
        stub
      end // end of [_]
  end // end of [formula_make]
  
  (* ****** ****** *)
  
  implement make_true (env) =
      $SMT.make_true (env.smt)
  
  (* ****** ****** *)
    
  implement smtenv_assert_sbexp (env, prop) = let
    val assumption = formula_make (env, prop)
    val _ = if log_smt then println! (
      "(assert ", $SMT.string_of_formula (env.smt, assumption),")"
    )
  in 
    $SMT.assert (env.smt, assumption)
  end

  implement smtenv_assert_formula (env, prop) = let
    val nprop = $SMT.make_not (env.smt, prop)
    val _ = if log_smt then println! (
      "(assert ", $SMT.string_of_formula (env.smt, nprop), ")"
    )
  in
    $SMT.assert (env.smt, nprop)
  end
  
  (* ****** ******  *)
  
  implement smtenv_check (env) = let
    val _ = if log_smt then println!("(check-sat)")
  in
    $SMT.check (env.smt)
  end
  
  (* ****** ******  *)

  #define :: list_cons
  
  implement f_identity (env, s2es) = let
    val- s2e1 ::  _  = s2es
  in
    formula_make (env, s2e1)
  end // end of [f_identity]

  implement  f_neg_bool (env, s2es) = let
    val- s2e :: _ = s2es
    val fbe = formula_make (env, s2e)
  in
    $SMT.make_not(env.smt , fbe)
  end // end of [f_neg_bool]
  
  implement f_add_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_or2 (env.smt, fbe1, fbe2)
  end // end of [f_add_bool_bool]
  
  implement f_mul_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _  = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_and2 (env.smt, fbe1, fbe2)
  end // end of [f_mul_bool_bool]

  implement f_eq_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_eq(env.smt, fbe1, fbe2)
  end // end of [f_eq_bool_bool]

  implement f_neq_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
    val eq = $SMT.make_eq (env.smt, fbe1, fbe2)
  in
    $SMT.make_not (env.smt, eq)
  end // end of [f_neq_bool_bool]
  
  implement f_neg_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
  in 
    $SMT.make_negate (env.smt, fbe1)
  end // end of [f_neg_int]
  
  implement f_add_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_add2 (env.smt, fbe1, fbe2)
  end // end of [f_add_int_int]

  implement f_sub_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_sub2 (env.smt, fbe1, fbe2)
  end // end of [f_sub_int_int]

  implement f_mul_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_mul2 (env.smt, fbe1, fbe2)
  end // end of [f_mul_int_int]
  
  implement f_ndiv_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_div (env.smt, fbe1, fbe2)
  end // end of [f_ndiv_int_int]

  implement f_idiv_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_div (env.smt, fbe1, fbe2)
  end // end of [f_idiv_int_int]

  implement f_lt_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_lt (env.smt, fbe1, fbe2)
  end // end of [f_lt_int_int]

  implement f_lte_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_le (env.smt, fbe1, fbe2)
  end // end of [f_lte_int_int]

  implement f_gt_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_gt (env.smt, fbe1, fbe2)
  end // end of [f_gt_int_int]

  implement f_gte_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_ge (env.smt, fbe1, fbe2)
  end // end of [f_gte_int_int]

  implement f_eq_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    $SMT.make_eq (env.smt, fbe1, fbe2)
  end // end of [f_eq_int_int]

  implement f_neq_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
    val eq   = $SMT.make_eq (env.smt, fbe1, fbe2)
  in
    $SMT.make_not (env.smt, eq)
  end // end of [f_neq_int_int]
  
  implement f_abs_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    //
    val fie1 = formula_make (env, s2e1)
    val zero = $SMT.make_numeral (env.smt, 0, env.sorts.integer)
    val fie1' = $SMT.formula_dup (env.smt, fie1)
    val fie1'' = $SMT.formula_dup (env.smt, fie1)
    val neg = $SMT.make_negate (env.smt, fie1')
    val check_lt = $SMT.make_lt (env.smt, fie1, zero)
  in
    $SMT.make_ite (env.smt, check_lt, neg, fie1'')
  end
  
  implement f_sgn_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    //
    val pos  = $SMT.make_numeral (env.smt, 1, env.sorts.integer)
    val zero  = $SMT.make_numeral (env.smt, 0, env.sorts.integer)
    val zero' = $SMT.make_numeral (env.smt, 0, env.sorts.integer)
    val zero'' = $SMT.make_numeral (env.smt, 0, env.sorts.integer)
    val neg  = $SMT.make_numeral  (env.smt, ~1, env.sorts.integer)
    //
    val fbe1 = formula_make (env, s2e1)
    val fbe1' = $SMT.formula_dup (env.smt, fbe1)
    //
    val check_neg = $SMT.make_lt (env.smt, fbe1, zero)
    val check_zero = $SMT.make_eq (env.smt, fbe1', zero')
    //
    val cond1 = $SMT.make_ite (env.smt, check_zero, zero'', pos)
    val cond2 = $SMT.make_ite (env.smt, check_neg,  neg, cond1)
  in
    cond2
  end // end of [f_sgn_int]
 
  implement f_max_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    //
    val fbe1 = formula_make (env, s2e1)
    val fbe1' = $SMT.formula_dup (env.smt, fbe1)
    val fbe2  = formula_make (env, s2e2)
    val fbe2' = $SMT.formula_dup (env.smt, fbe2)
    //
    val gt = $SMT.make_gt (env.smt, fbe1, fbe2)
  in
    $SMT.make_ite (env.smt, gt, fbe1', fbe2')
  end // end of [f_max_int_int]

  implement f_min_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    //
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
    val fbe1' = $SMT.formula_dup (env.smt, fbe1)
    val fbe2' = $SMT.formula_dup (env.smt, fbe2)
    //
    val gt = $SMT.make_le (env.smt, fbe1, fbe2)
  in
    $SMT.make_ite (env.smt, gt, fbe1', fbe2')
  end // end of [f_min_int_int]

  implement f_ifint_bool_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: s2e3 ::  _ = s2es
    //
    val cond = formula_make (env, s2e1)
    val t = formula_make (env, s2e2)
    val f = formula_make (env, s2e3)
    //
  in
    $SMT.make_ite (env.smt, cond, t, f)
  end // end of [f_ifint_bool_int_int]
  
end
