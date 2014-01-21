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

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "constraint.sats"
staload "solving/error.sats"
staload "solving/solver.sats"
staload SMT = "solving/smt.sats"

(* ****** ****** *)

viewtypedef solver = $SMT.solver
viewtypedef formula = $SMT.formula
viewtypedef sort = $SMT.sort

(* ****** ****** *)

staload "solving/error.sats"

(* ****** ****** *)

val log_smt = true

(* ****** ****** *)

local
  staload TreeMap = "libats/SATS/linmap_avltree.sats"
  staload _(*anon*) = "libats/DATS/linmap_avltree.dats"

  staload ListMap = "libats/SATS/linmap_list.sats"
  staload _(*anon*) = "libats/DATS/linmap_list.dats"
  
  fun cmp (
    x1: s2var, x2: s2var
  ) : int = compare_s2var_s2var (x1, x2)
  
  implement $TreeMap.compare_key_key<s2var> (k1, k2) =
    $effmask_all compare_s2var_s2var (k1, k2)
  
  implement $ListMap.equal_key_key<s3ubexp> (s1, s2) =
    $effmask_all s3ubexp_syneq (s1, s2)
    
  viewtypedef smtenv_struct = @{
    smt= solver,
    variables= @{
      (* 
        Map static variables to their respective SMT formulas
      *)
      statics= $TreeMap.map (s2var, formula),
      substitutes= $ListMap.map (s3ubexp, s2var)
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
    env.variables.statics := 
      $TreeMap.linmap_make_nil {s2var,formula} ();
    env.variables.substitutes := 
      $ListMap.linmap_make_nil {s3ubexp, s2var} ();
    env.sorts.integer := $SMT.make_int_sort ();
    env.sorts.boolean := $SMT.make_bool_sort ();
    env.err := 0;
  end

  implement smtenv_free (env) = let
   val map = env.variables.statics
   val statics = $TreeMap.linmap_listize<s2var,formula> (map)
   //
   viewtypedef binding = @(s2var, formula)
   //
   fun release_vars (slv: !solver, vs: List_vt (binding)): void =
    case+ vs of 
      | ~list_vt_nil () => ()
      | ~list_vt_cons (bind, vss) => let
        val @(_, v) = bind
        val _ = $SMT.formula_free (v)
      in 
        release_vars (slv, vss)
      end
   //
   in 
      release_vars (env.smt, statics);
      $ListMap.linmap_free (env.variables.substitutes);
      $SMT.sort_free (env.sorts.integer);
      $SMT.sort_free (env.sorts.boolean);
      $SMT.delete_solver (env.smt)
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
          smtenv_get_var_exn (env, s2v)
       end
  end
  
  implement smtenv_find_substitution (env, sub) = let
    val optv = 
      $ListMap.linmap_search_opt<s3ubexp, s2var> (env.variables.substitutes, sub)
  in
    case+ optv of
      | ~Some_vt (s2v) => Some {s2var} (s2v)
      | ~None_vt () => None {s2var} ()
  end

  implement smtenv_make_substitution (env, exp, s2v) = {
    var res : s2var
    val _ = 
      $ListMap.linmap_insert (env.variables.substitutes, exp, s2v, res)
    prval () = opt_clear (res)
  }
  
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
  
  fun
  sort_of_s2rt (type: s2rt): sort =
      if s2rt_is_int (type) || s2rt_is_addr (type) then
        $SMT.make_int_sort ()
      else if s2rt_is_bitvec (type) then let
        val width = s2rt_bitvec_get_width (type)
        val () = assertloc (width > 0)
      in
        $SMT.make_bitvec_sort (width)
      end
      else if s2rt_is_array (type) then
        $SMT.make_array_sort ()
      else
        $SMT.make_bool_sort ()
  
  implement smtenv_add_svar (env, s2v) = let
    val () = fprintln! (stdout_ref, "Adding svar: ", s2v)
    val type = s2var_get_srt (s2v)
    //
    val smt_type = sort_of_s2rt (type)
    //
    val stamp = s2var_get_stamp (s2v)
    val id = stamp_get_int (stamp)
    val () = if log_smt then
      println! ("Variables: ",
        $TreeMap.linmap_size<s2var, formula> (env.variables.statics)
    )
    //
    val fresh = $SMT.make_int_constant (id, smt_type)
    val () = $SMT.sort_free(smt_type)
    var res: formula?
    val found =
      $TreeMap.linmap_insert<s2var, formula> (
        env.variables.statics, s2v, fresh, res
      )
  in
      if found then let
        prval () = opt_unsome {formula} (res)
      in
        $SMT.formula_free (res)
      end
      else {
        prval () = opt_unnone {formula} (res)
      }
  end
  
  implement smtenv_get_var_exn (env, s2v) = let
    val [l:addr] ptr =
      $TreeMap.linmap_search_ref<s2var, formula> (env.variables.statics, s2v)
  in
    if iseqz{formula} (ptr) then
      $raise FatalErrorException () where {
        val () = println! ("SMT formula not found for s2var")
      }
      (*
        The C code from the following wouldn't compile:
        abort {formula} ()
      *)
    else let
      val ptr1 = cptr2ptr {formula} (ptr)
      val (pf, free | p) = $UN.ptr1_vtake {formula} (ptr1)
      val variable = $SMT.formula_dup (!ptr1)
      prval () = free (pf)
    in
      variable
    end
  end
  
  implement formula_make (env, s2e) = let
    val out = stdout_ref
  in
    case+ s2e.s2exp_node of
      | S2Eint i =>
        $SMT.make_numeral (i, env.sorts.integer)
      //
      | S2Eintinf i =>
        $SMT.make_numeral (i, env.sorts.integer)
      //
      | S2Evar s2v => smtenv_get_var_exn (env, s2v)
      | S2Ecst s2c => (case+ s2c of
        | _ when
            equal_string_s2cst ("null_addr", s2c) =>
              $SMT.make_numeral (0, env.sorts.integer)
        //
        | _ when
            equal_string_s2cst ("true_bool", s2c) =>
              $SMT.make_true ()
        | _ when
            equal_string_s2cst ("false_bool", s2c) =>
              $SMT.make_false ()
        | _ => let
          val srt   = s2cst_get_srt (s2c)
          val stamp = s2cst_get_stamp (s2c)
          val id    = stamp_get_int (stamp)
        in
           if s2rt_is_int (srt) orelse s2rt_is_addr (srt) then
            $SMT.make_int_constant (id, env.sorts.integer)
           else if s2rt_is_bool (srt) then let
            in $SMT.make_int_constant (id, env.sorts.boolean) end
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
        $SMT.make_eq (lhs, rhs)
      end
      | S2Eapp
          (s2e1, s2es2) => (
            case+ s2e1.s2exp_node of
              | S2Ecst s2c1 => let
               in
                formula_make_s2cst_s2explst (env, s2c1, s2es2)
               end
              //
              | _ => $raise FatalErrorException () where {
                val _ = fprintln! (out, "formula_make: Invalid application ", s2e)
              }
          ) // end of [S2Eapp]
      | S2Emetdec (s2e_met) => let
      in
        formula_make (env, s2e_met)
      end // end of [S3Emetdec]
      (*
        Ignore size of for now, taking s2zexp_make_s2exp
        out of the default typechecker seems a little tricky
        right now
      | S2Esizeof (s2exp) => let
        val s2ze = s2zexp_make_s2exp (s2exp)
        val s3ub = s3ubexp_sizeof (s2ze)
      in
        formula_from_substitution (env, s3ub)
      end
      *)
      | _ => let
        val srt = s2e.s2exp_srt
        val stub = (
            if s2rt_is_int (srt) orelse s2rt_is_addr (srt) then
              $SMT.make_fresh_constant (env.sorts.integer)
            //
            else if s2rt_is_bitvec (srt) then let
              val width = s2rt_bitvec_get_width (srt)
              val () = assertloc (width > 0)
              val () = println! ("translating bitvec...", width)
              val bv = $SMT.make_bitvec_sort (width)
              val cst = $SMT.make_fresh_constant (bv)
              val () = $SMT.sort_free (bv)
            in cst end
            //
            else
              $SMT.make_fresh_constant (env.sorts.boolean)
        ): formula
        (* TODO: Make this error mean something to calling functions *)
        val _ = env.err := env.err + 1
        val _ = fprintln! (out, "warning(3): formula_make: s2e =:", s2e)
      in
        stub
      end // end of [_]
   end // end of [formula_make]
   
  (* ****** ****** *)
  
  implement make_true (env) = $SMT.make_true ()
  
  (* ****** ****** *)

  implement smtenv_assert_sbexp (env, prop) = let
    val assumption = formula_make (env, prop)
    val _ = if log_smt then println! (
      "(assert ", $SMT.string_of_formula (assumption) ,")"
    )
  in 
    $SMT.assert (env.smt, assumption)
  end
  
  implement smtenv_formula_is_valid (env, wff) = let
    val () = println! ("(is-valid", $SMT.string_of_formula (wff), ")")
  in
    $SMT.is_valid (env.smt, wff)
  end

end // end of [local]

(* ****** ******  *)

(*
  If someone wants to add a function to extend the power of the statics,
  it will be implemented here. TODO: put these functions in their own file.
*)

(* ****** ******  *)

local

staload "solving/smt_ML.sats"

in

  #define :: list_cons
  
  implement f_identity (env, s2es) = let
    val- s2e1 ::  _  = s2es
  in
    formula_make (env, s2e1)
  end // end of [f_identity]

  implement  f_neg_bool (env, s2es) = let
    val- s2e :: _ = s2es
    val boole = formula_make (env, s2e)
  in
    Not (boole)
  end // end of [f_neg_bool]
  
  implement f_add_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val b0 = formula_make (env, s2e1)
    val b1 = formula_make (env, s2e2)
  in
    (b0 Or b1)
  end // end of [f_add_bool_bool]
  
  implement f_mul_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _  = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    (fbe1 And fbe2)
  end // end of [f_mul_bool_bool]

  implement f_eq_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    fbe1 = fbe2
  end // end of [f_eq_bool_bool]

  implement f_neq_bool_bool (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    Not (fbe1 = fbe2)
  end // end of [f_neq_bool_bool]
  
  implement f_neg_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    val n = formula_make (env, s2e1)
  in 
    ~n
  end // end of [f_neg_int]
  
  implement f_add_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    fbe1 + fbe2
  end // end of [f_add_int_int]

  implement f_sub_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val fbe1 = formula_make (env, s2e1)
    val fbe2 = formula_make (env, s2e2)
  in
    fbe1 - fbe2
  end // end of [f_sub_int_int]

  implement f_mul_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val p = formula_make (env, s2e1)
    val q = formula_make (env, s2e2)
  in
    p * q
  end // end of [f_mul_int_int]
  
  implement f_ndiv_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val n = formula_make (env, s2e1)
    val d = formula_make (env, s2e2)
  in
    n / d
  end // end of [f_ndiv_int_int]

  implement f_idiv_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val n = formula_make (env, s2e1)
    val d = formula_make (env, s2e2)
  in
    n / d
  end // end of [f_idiv_int_int]

  implement f_lt_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val small = formula_make (env, s2e1)
    val great = formula_make (env, s2e2)
  in
    small < great
  end // end of [f_lt_int_int]

  implement f_lte_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val small = formula_make (env, s2e1)
    val great = formula_make (env, s2e2)
  in
    small <= great
  end // end of [f_lte_int_int]

  implement f_gt_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val great = formula_make (env, s2e1)
    val small = formula_make (env, s2e2)
  in
    great > small
  end // end of [f_gt_int_int]

  implement f_gte_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val great = formula_make (env, s2e1)
    val small = formula_make (env, s2e2)
  in
    great >= small
  end // end of [f_gte_int_int]

  implement f_eq_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val lhs = formula_make (env, s2e1)
    val rhs = formula_make (env, s2e2)
  in
    lhs = rhs
  end // end of [f_eq_int_int]

  implement f_neq_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val lhs = formula_make (env, s2e1)
    val rhs = formula_make (env, s2e2)
  in
    Not (lhs = rhs)
  end // end of [f_neq_int_int]
  
  implement f_abs_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    val i = formula_make (env, s2e1)
  in
    If (^i < Int(0), ~(^i), i)
  end

  implement f_sgn_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    val i = formula_make (env, s2e1)
  in
    If (^i < Int (0), Int (~1),
      If ( i = Int (0), Int (0), Int (1)))
  end // end of [f_sgn_int]

  implement f_max_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    val i = formula_make (env, s2e1)
    val j  = formula_make (env, s2e2)
  in
    If (^i >= ^j, i, j)
  end // end of [f_max_int_int]

  implement f_min_int_int (env, s2es) = let
    val- s2e1 :: s2e2 ::  _ = s2es
    //
    val i = formula_make (env, s2e1)
    val j = formula_make (env, s2e2)
  in
    If (^i <= ^j, i, j)
  end // end of [f_min_int_int]

  implement f_ifint_bool_int_int (env, s2es) = let
    val- s2e1 :: s2e2 :: s2e3 ::  _ = s2es
    //
    val cond = formula_make (env, s2e1)
    val T = formula_make (env, s2e2)
    val F = formula_make (env, s2e3)
    //
  in
    If (cond, T, F)
  end // end of [f_ifint_bool_int_int]
  
  implement
  f_bv8_of_int (env, s2es) = let
    val- s2e1 :: _ = s2es
    //
    val i = formula_make (env, s2e1)
  in
    $SMT.make_bv_from_int (8, i)
  end

  implement
  f_sub_bv_bv (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val l = formula_make (env, s2e1)
    val r = formula_make (env, s2e2)
  in
    $SMT.make_bv_sub2 (l, r)
  end

  implement
  f_add_bv_bv (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val l = formula_make (env, s2e1)
    val r = formula_make (env, s2e2)
  in
    $SMT.make_bv_add2 (l, r)
  end

  implement
  f_land_bv_bv (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val l = formula_make (env, s2e1)
    val r = formula_make (env, s2e2)
  in
    $SMT.make_bv_land2 (l, r)
  end
  
  implement
  f_eq_bv_bv (env, s2es) = let
    val- s2e1 :: s2e2 :: _ = s2es
    val l = formula_make (env, s2e1)
    val r = formula_make (env, s2e2)
  in
    $SMT.make_bv_eq (l, r)
  end
  
  implement
  f_partitioned_array (env, s2es) = let
    val- s2e1 :: s2e2 :: s2e3 :: s2e4 :: _ = s2es
    val a     = formula_make (env, s2e1)
    val start = formula_make (env, s2e2)
    val p     = formula_make (env, s2e3)
    val stop  = formula_make (env, s2e4)
    //
    val i = Int ("i"); val j = Int ("j")
  in
    ForAll (^i, ^j,
      ((start <= ^i) And (^i <= ^p) And (^p <= ^j) 
        And (^j <= stop)) ==>
          (((Select(^a, i)) <= (Select(^a, ^p))) 
            And ((Select(^a, p)) <= (Select(a, j)))))
  end
  
  implement
  f_sorted_array (env, s2es) = let
    val- s2e1 :: s2e2 :: s2e3 :: _ = s2es
    val a     = formula_make (env, s2e1)
    val start = formula_make (env, s2e2)
    val stop  = formula_make (env, s2e3)
    //
    val i = Int ("i"); val j = Int ("j")
  in
    ForAll (^i, ^j,
      ((start <= ^i) And (^i <= ^j) And (^j <= stop)) ==> 
        (Select (^a, i) <= Select (a, j))
      )
  end
  
  implement
  f_merged_array (env, s2es) = let
    val- s2e1 :: s2e2 :: s2e3 :: s2e4 :: s2e5 :: _ = s2es
    val a     = formula_make (env, s2e1)
    val left  = formula_make (env, s2e2)
    val right = formula_make (env, s2e3)
    val pivot = formula_make (env, s2e4)
    val n     = formula_make (env, s2e5)
    
    val i = Int ("i"); val j = Int("j")
  in
    ForAll (^i,
      ((Int(0) <= ^i) And (^i <= (^pivot - Int(1)))) ==> 
        (Select (^a, ^i) = Select (left, i)))
    And ForAll (^j, 
      (((^pivot + Int(1)) <= ^j) And (^j <= n)) ==>
        (Select (a, ^j) = Select (right, j - (pivot + Int(1)))))
  end
  
end // end of [local]
