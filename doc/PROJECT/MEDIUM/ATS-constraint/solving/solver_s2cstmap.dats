(*
  Implementing the map that translates instants of static functions
  into formulas understood by the underlying SMT solver.
*)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "constraint.sats"
staload "solving/smt.sats"
staload "solving/solver.sats"

staload ERR = "solving/error.sats"

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/funmap_list.sats"
staload _ = "libats/DATS/funmap_list.dats"

(* ****** ****** *)

typedef s2cst_ftype = (&smtenv, s2explst) -<fun1> formula

assume s2cfunmap = map (symbol, s2cst_ftype)

implement 
equal_key_key<symbol> (s0, s1) = 
  compare_symbol_symbol (s0, s1) = 0

local
  var the_s2cfunmap: s2cfunmap = funmap_make_nil{symbol,s2cst_ftype} ()
in
  val the_s2cfunmap =
    ref_make_viewptr (view@ (the_s2cfunmap) | addr@ (the_s2cfunmap))
end

extern
fun constraint3_initialize_map (map: &s2cfunmap): void

implement 
constraint3_initialize () = {
  val (pf, free | p) = $UN.ref_vtake {s2cfunmap} (the_s2cfunmap)
  val () = constraint3_initialize_map (!p)
  prval () = free (pf)
}

implement
formula_make_s2cst_s2explst
  (env, s2c, s2es) = let
  val (vbox pf | p) = ref_get_viewptr{s2cfunmap} (the_s2cfunmap)
  val sym = s2c.name
  val opt = $effmask_ref funmap_search_opt<symbol,s2cst_ftype> (!p, sym)
  //
  in
    case+ opt of
      | ~Some_vt f => $effmask_ref f (env, s2es)
      | ~None_vt _ => let
        val function = s2c
        val args = s2es
        val app  = $effmask_ref s3ubexp_app (function, args)
      in
        $effmask_ref formula_from_substitution (env, app)
      end
  end // end of [formula_make_s2cst_s2explst]

implement 
constraint3_initialize_map (map) = {
  typedef tfun = s2cst_ftype
  fun ins (
    map: &s2cfunmap, key: string, f: tfun
  ): void = let
    val sym = symbol_make (key)
  in
    funmap_insert_any<symbol, tfun> (map, sym, f)
  end
  val () = begin
    ins (map, "neg_bool", f_neg_bool);
    ins (map, "add_bool_bool", f_add_bool_bool);
    ins (map, "mul_bool_bool", f_mul_bool_bool);
    ins (map, "eq_bool_bool", f_eq_bool_bool);
    ins (map, "neq_bool_bool", f_neq_bool_bool);
    //
    ins (map, "neg_int", f_neg_int);
    ins (map, "add_int_int", f_add_int_int);
    ins (map, "sub_int_int", f_sub_int_int);
    ins (map, "mul_int_int", f_mul_int_int);
    ins (map, "div_int_int", f_idiv_int_int);
    ins (map, "ndiv_int_int", f_ndiv_int_int);
    ins (map, "idiv_int_int", f_idiv_int_int);
    //
    ins (map, "lt_int_int", f_lt_int_int);
    ins (map, "lte_int_int", f_lte_int_int);
    ins (map, "gt_int_int", f_gt_int_int);
    ins (map, "gte_int_int", f_gte_int_int);
    ins (map, "eq_int_int", f_eq_int_int);
    ins (map, "neq_int_int", f_neq_int_int);
    //
    ins (map, "abs_int", f_abs_int);
    ins (map, "sgn_int", f_sgn_int);
    ins (map, "max_int_int", f_max_int_int);
    ins (map, "min_int_int", f_min_int_int);
    //
    ins (map, "ifint_bool_int_int", f_ifint_bool_int_int);
    //
    ins (map, "int_of_addr", f_identity);
    ins (map, "addr_of_int", f_identity);
    //
    ins (map, "add_addr_int", f_add_int_int);
    ins (map, "sub_addr_int", f_sub_int_int);
    ins (map, "sub_addr_addr", f_sub_int_int);
    //
    ins (map, "lt_addr_addr", f_lt_int_int);
    ins (map, "lte_addr_addr", f_lte_int_int);
    ins (map, "gt_addr_addr", f_gt_int_int);
    ins (map, "gte_addr_addr", f_gte_int_int);
    ins (map, "eq_addr_addr", f_eq_int_int);
    ins (map, "neq_addr_addr", f_neq_int_int);
    //
    // ins (map, "lte_cls_cls", f_lte_cls_cls);
  end
}

(* ****** ****** *)