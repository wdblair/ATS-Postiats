/***********************************************************************/
/*                                                                     */
/*                         Applied Type System                         */
/*                                                                     */
/***********************************************************************/

/* (*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
*) */

/* ****** ****** */

#ifndef Z3_Z3_QUANTIFIER_CATS
#define Z3_Z3_QUANTIFIER_CATS

/* ****** ****** */

Z3_DECLARE_MK_AST(Z3_mk_forall, unsigned weight, unsigned num_patterns, Z3_pattern const patterns[], unsigned num_decls, Z3_sort const sorts[], Z3_symbol const decl_names[], Z3_ast body) {
  Z3_BODY_MK_AST(Z3_mk_forall, weight, num_patterns, patterns, num_decls, sorts, decl_names, body)
}

Z3_DECLARE_MK_AST(Z3_mk_bound, unsigned index, Z3_sort ty) {
  Z3_BODY_MK_AST(Z3_mk_bound, index, ty)
}

/* ****** ****** */

#endif

/* end of [z3_quantifier.cats] */
