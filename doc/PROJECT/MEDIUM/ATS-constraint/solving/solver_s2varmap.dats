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
// Start Time: August, 2014
//
(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "solving/solver.sats"
staload SMT = "solving/smt.sats"

(* ****** ****** *)

staload Map = "libats/SATS/linmap_avltree.sats"
staload _ = "libats/DATS/linmap_avltree.dats"

staload Set = "libats/SATS/linset_listord.sats"
staload _ = "libats/DATS/linset_listord.dats"

staload Stack = "stack.sats"

(* ****** ****** *)

local
  vtypedef formula = $SMT.formula

  vtypedef stack (a:vtype) = $Stack.stack (a)
  vtypedef set (a:t@ype) = $Set.set (a)
  vtypedef s2varset = set (s2var)
  
  fun cmp (
    x1: s2var, x2: s2var
  ) : int = compare_s2var_s2var (x1, x2)
  
  implement $Map.compare_key_key<s2var> (k1, k2) =
    $effmask_all compare_s2var_s2var (k1, k2)
    
  implement $Set.compare_elt_elt<s2var> (k1, k2) =
    $effmask_all compare_s2var_s2var (k1, k2)
   
  assume s2varmap_vt0ype (a:vt@ype) = @{
    scopes= stack (s2varset),
    variables= $Map.map (s2var, a)
  }
in
  implement{a}
  s2varmap_nil (map) = begin
    map.scopes := $Stack.stack_nil();
    map.variables := $Map.linmap_nil ();
  end
  
  implement{a}
  s2varmap_delete (map) = let
    val scopes = $Stack.stack_listize (map.scopes)
    val vars = $Map.linmap_listize (map.variables)
  in
    list_vt_freelin(scopes);
    list_vt_freelin(vars) where {
    //
    implement
    list_vt_freelin$clear<set(s2var)> (set) =
      $Set.linset_free (set)
    //
    implement 
    list_vt_freelin$clear<a>(x) = $effmask_all (
      s2varmap_element_free<a>(x)
    )}
  end
  
end

(**
  An example from the previous implementation for reference.
  
    val [l:addr] ptr =
      $TreeMap.linmap_search_ref (env.variables.statics, s2v)
  in
    if iseqz (ptr) then let
      val () = fprintln! (stderr_ref, "warning: adding s2var: ", s2v)
      val () = smtenv_add_svar (env, s2v)
    in
      smtenv_get_var_exn (env, s2v)
    end
    else let
      val ptr1 = cptr2ptr (ptr)
      val (pf, free | p) = $UN.ptr1_vtake (ptr1)
      val variable = $SMT.formula_dup (!ptr1)
      prval () = free (pf)
    in
      variable
    end
  end
*)