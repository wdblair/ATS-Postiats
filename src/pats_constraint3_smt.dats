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

#define ATS_DYNLOADFLAG 0

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

staload "./pats_smt.sats"

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
    val _ = env.smt := make_solver ()
    val _ = env.vars := $LM.linmap_make_nil ()
  }
  
  implement smtenv_free (env) = {
   val () = delete_solver (env.smt)
   val () = $LM.linmap_free (env.vars)
  }
  
  implement smtenv_push (env) = (pf | ()) where {
    val _ = solver_push (env.smt)
    prval pf = __push () where {
      extern praxi __push (): smtenv_push_v
    }
  }
  
  implement smtenv_pop (pf | env) = {
    val _ = solver_pop (env.smt)
    prval _ = __pop (pf) where {
      extern praxi __pop (pf: smtenv_push_v): void
    }
  }
  
  implement smtenv_add_svar (env, s2v) = {
    val type = s2var_get_srt (s2v)
    val smt_type =
      if s2rt_is_int (type) orelse s2rt_is_addr (type)
        orelse s2rt_is_char (type) orelse s2rt_is_dat (type) then
        make_int_sort (env.smt)
      else
        make_bool_sort (env.smt)
    (*
      Identifiy variables with a string eventually. That way we can
      provide meaningful counter examples to unsolved constraints.
    *)
    val fresh = make_fresh_constant (env.smt, smt_type)
    var res: sort
    val _ = $LM.linmap_insert (env.vars, s2v, fresh, cmp, res)
    prval () = opt_clear (res)
  }
  
  fun formula_of_s2exp (env: &smtenv, s2e: s2exp): formula =
    case+ s2e.s2exp_node of
      | S2Eint i => let
        val type = make_int_sort(env.smt)
      in
        make_numeral (env.smt, i, type)
      end
      | S2Eintinf i => let
        val type = make_int_sort(env.smt)
      in
        make_numeral (env.smt, i, type)
      end
      | _ => abort() where {
        val _ = println!("Invalid S2 expression given.")
      }
      
  implement smtenv_assert_sbexp (env, prop) = let
    val assumption = formula_of_s2exp (env, prop)
  in 
    assert(env.smt, assumption)
  end
end