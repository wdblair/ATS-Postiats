(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: February, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"

(* ****** ****** *)

staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_constraint3.sats"

(* ****** ****** *)

staload SMT = "./pats_smt.sats"
viewtypedef formula = $SMT.formula

(* ****** ****** *)

implement
constraint3_initialize_map (map) = let
//
typedef tfun = (&smtenv, s2explst) -<fun1> formula
//
fun ins (
  map: &s2cfunmap, r: s2cstref, f: tfun
) : void = let
  val s2c = s2cstref_get_cst (r)
  val map1 = $UN.cast {s2cstmap(tfun)} (map)
  val map2 = s2cstmap_add (map1, s2c, f)
  val () = map := $UN.cast {s2cfunmap} (map2)
in
  (*nothing*)
end // end of [ins]
//
val () = ins (map, the_neg_bool, f_neg_bool)
val () = ins (map, the_add_bool_bool, f_add_bool_bool)
val () = ins (map, the_mul_bool_bool, f_mul_bool_bool)
val () = ins (map, the_eq_bool_bool, f_eq_bool_bool)
val () = ins (map, the_neq_bool_bool, f_neq_bool_bool)
//
val () = ins (map, the_neg_int, f_neg_int)
val () = ins (map, the_add_int_int, f_add_int_int)
val () = ins (map, the_sub_int_int, f_sub_int_int)
val () = ins (map, the_mul_int_int, f_mul_int_int)
val () = ins (map, the_div_int_int, f_idiv_int_int)
val () = ins (map, the_ndiv_int_int, f_ndiv_int_int)
val () = ins (map, the_idiv_int_int, f_idiv_int_int)
//
val () = ins (map, the_lt_int_int, f_lt_int_int)
val () = ins (map, the_lte_int_int, f_lte_int_int)
val () = ins (map, the_gt_int_int, f_gt_int_int)
val () = ins (map, the_gte_int_int, f_gte_int_int)
val () = ins (map, the_eq_int_int, f_eq_int_int)
val () = ins (map, the_neq_int_int, f_neq_int_int)
//
val () = ins (map, the_abs_int, f_abs_int)
val () = ins (map, the_sgn_int, f_sgn_int)
val () = ins (map, the_max_int_int, f_max_int_int)
val () = ins (map, the_min_int_int, f_min_int_int)
//
val () = ins (map, the_ifint_bool_int_int, f_ifint_bool_int_int)
//
(*
val () = ins (map, the_int_of_bool, f_int_of_bool)
val () = ins (map, the_bool_of_int, f_bool_of_int)
*)
(*
val () = ins (map, the_int_of_char, f_identity) // HX: removed
val () = ins (map, the_char_of_int, f_identity) // HX: removed
*)
val () = ins (map, the_int_of_addr, f_identity)
val () = ins (map, the_addr_of_int, f_identity)
//
val () = ins (map, the_add_addr_int, f_add_int_int)
val () = ins (map, the_sub_addr_int, f_sub_int_int)
val () = ins (map, the_sub_addr_addr, f_sub_int_int)
//
val () = ins (map, the_lt_addr_addr, f_lt_int_int)
val () = ins (map, the_lte_addr_addr, f_lte_int_int)
val () = ins (map, the_gt_addr_addr, f_gt_int_int)
val () = ins (map, the_gte_addr_addr, f_gte_int_int)
val () = ins (map, the_eq_addr_addr, f_eq_int_int)
val () = ins (map, the_neq_addr_addr, f_neq_int_int)
//
(*
val () = ins (map, the_lte_cls_cls, f_lte_cls_cls)
*)
(*
val () = ins (map, the_gte_cls_cls, f_gte_cls_cls)
*)
//
in
  (*nothing*)
end // end of [constraint3_initialize_map]

(* ****** ****** *)

(* end of [pats_constraint3_init.dats] *)
