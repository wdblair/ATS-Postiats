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
typedef formula = $SMT.formula

(* ****** ****** *)

staload "./pats_stamp.sats"

(* ****** ****** *)

staload "./pats_error.sats"

(* ****** ****** *)

local

staload LM = "libats/SATS/linmap_avltree.sats"
staload _(*anon*) = "libats/DATS/linmap_avltree.dats"

fn cmp (
  x1: s2var, x2: s2var
) :<cloref> int = compare_s2var_s2var (x1, x2)

viewtypedef smtenv_struct = @{
  smt=solver,
  vars= $LM.map(s2var, formula)
}

assume smtenv_viewtype = smtenv_struct

in
  implement smtenv_nil (env) = {
    val _ = env.smt := $SMT.make_solver ()
    val _ = env.vars := $LM.linmap_make_nil ()
  }
  
  implement smtenv_free (env) = {
   val () = $SMT.delete_solver (env.smt)
   val () = $LM.linmap_free (env.vars)
  }
  
  implement smtenv_push (env) = (pf | ()) where {
    val _ = println! ("(push 1)")
    val _ = $SMT.push (env.smt)
    prval pf = __push () where {
      extern praxi __push (): smtenv_push_v
    }
  }
  
  implement smtenv_pop (pf | env) = {
    val _ = println! ("(pop 1)")
    val _ = $SMT.pop (env.smt)
    prval _ = __pop (pf) where {
      extern praxi __pop (pf: smtenv_push_v): void
    }
  }
 
  implement smtenv_add_svar (env, s2v) = {
    val type = s2var_get_srt (s2v)
    var is_int : bool
    val smt_type =
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
    val stamp = s2var_get_stamp (s2v)
    val id = stamp_get_int (stamp)
    val _ = println!("Variables: ", $LM.linmap_size(env.vars))
    //
    val label = if is_int then "Int" else "Bool"
    val _ = println! ("(declare-fun k!", id, " () ", label, ")")
    //
    val fresh = $SMT.make_int_constant (env.smt, id, smt_type)
    var res: $SMT.sort
    val _ = $LM.linmap_insert (env.vars, s2v, fresh, cmp, res)
    prval () = opt_clear (res)
  }

  implement smtenv_get_var_exn (env, s2v) = let
    val opt = $LM.linmap_search_opt (env.vars, s2v, cmp)
  in
    case+ opt of 
      | ~Some_vt (formula) => formula
      | ~None_vt _ => abort () where {
        val _ = prerrln! ("SMT formula not found for s2var: ", s2v)
      }
  end
  
  (* ****** ****** *)
  
  implement formula_make (env, s2e) = let
    val s2e = s2exp_hnfize_smt (s2e)
  in
    case+ s2e.s2exp_node of
      | S2Eint i => let
        val type = $SMT.make_int_sort (env.smt)
      in
        $SMT.make_numeral (env.smt, i, type)
      end
      | S2Eintinf i => let
        val type = $SMT.make_int_sort (env.smt)
      in
        $SMT.make_numeral (env.smt, i, type)
      end
      | S2Evar s2v => smtenv_get_var_exn (env, s2v)
      | S2Ecst s2c => (case+ s2c of
        | _ when
            s2cstref_equ_cst (the_null_addr, s2c) => let
              val ty = $SMT.make_int_sort (env.smt)
              val zero = $SMT.make_numeral (env.smt, 0, ty)
            in
              zero
            end
        | _ when
            s2cstref_equ_cst (the_true_bool, s2c) =>
              $SMT.make_true (env.smt)
        | _ when
            s2cstref_equ_cst (the_false_bool, s2c) =>
              $SMT.make_false (env.smt)
        | _ => let
          val srt = s2cst_get_srt (s2c)
          val ty  = if s2rt_is_int (srt) orelse s2rt_is_addr (srt)
                      orelse s2rt_is_char (srt) then
                        $SMT.make_int_sort (env.smt)
                    else
                      $SMT.make_bool_sort (env.smt)
          val stamp = s2cst_get_stamp (s2c)
          val id    = stamp_get_int (stamp)
        in
          $SMT.make_int_constant (env.smt, id, ty)
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
                val _ = prerrln! ("Invalid application", s2e)
              }
          ) // end of [S2Eapp]
      | S2Emetdec (met, met_bound) => let
        val s2e_met = s2exp_metdec_reduce (met, met_bound)
      in
        formula_make (env, s2e_met)
      end // end of [S3Emetdec]
      | _ => abort () where {
        val _ = prerrln! "Invalid S2 expression given:"
        val _ = prerrln! s2e
      }
  end // end of [formula_make]
  
  (* ****** ****** *)
  
  implement make_true (env) = let
    val ty = $SMT.make_bool_sort(env.smt)
  in
    $SMT.make_fresh_constant(env.smt, ty)
  end
  
  (* ****** ****** *)
    
  implement smtenv_assert_sbexp (env, prop) = let
    val assumption = formula_make (env, prop)
    val _ = println! (
      "(assert ", $SMT.string_of_formula(env.smt, assumption),")"
    )
  in 
    $SMT.assert (env.smt, assumption)
  end

  implement smtenv_assert_formula (env, prop) = let
    val nprop = $SMT.make_not (env.smt, prop)
    val _ = println! (
      "(assert ", $SMT.string_of_formula (env.smt, nprop), ")"
    )
  in
    $SMT.assert (env.smt, nprop)
  end
  
  (* ****** ******  *)
  
  implement smtenv_check (env) = let
    val _ = println!("(check-sat)")
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
    val ty = $SMT.make_int_sort (env.smt)
    val zero = $SMT.make_numeral (env.smt, 0, ty)
    val neg = $SMT.make_negate (env.smt, fie1)
    val check_lt = $SMT.make_lt (env.smt, fie1, zero)
  in
    $SMT.make_ite (env.smt, check_lt, neg, fie1)
  end
  
  implement f_sgn_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    val ty   = $SMT.make_int_sort (env.smt)
    val pos  = $SMT.make_numeral (env.smt, 1, ty)
    val zero = $SMT.make_numeral (env.smt, 0, ty)
    val neg  = $SMT.make_numeral  (env.smt, ~1, ty)
    //
    val fbe1 = formula_make (env, s2e1)
    //
    val check_neg = $SMT.make_lt (env.smt, fbe1, zero)
    val check_zero = $SMT.make_eq (env.smt, fbe1, zero)
    //
    val cond1 = $SMT.make_ite (env.smt, check_zero, zero, pos)
    val cond2 = $SMT.make_ite (env.smt, check_neg,  neg, cond1)
  in
    cond2
  end // end of [f_sgn_int]
 
  implement f_max_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    //
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
    //
    val gt = $SMT.make_gt (env.smt, fbe1, fbe2)
  in
    $SMT.make_ite (env.smt, gt, fbe1, fbe2)
  end // end of [f_max_int_int]

  implement f_min_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    //
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
    //
    val gt = $SMT.make_le (env.smt, fbe1, fbe2)
  in
    $SMT.make_ite (env.smt, gt, fbe1, fbe2)
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
