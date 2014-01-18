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
// Start Time: January, 2014
//
(* ****** ****** *)

staload "solving/smt.sats"
staload "solving/smt_ML.sats"

(* ****** ****** *)

implement 
FormulaDup (f) = let
  val slv = the_solver_get ()
  val f' = formula_dup (slv, f)
in
  ~slv;
  f'
end

implement
FormulaFree (f) = let
  val slv = the_solver_get ()
  val f' = formula_free (slv, f)
in
  ~slv
end

(* ****** ****** *)