(*
  Some basic tests for the ATS Z3 Library
*)

staload "contrib/SMT/Z3/SATS/z3.sats"
staload "contrib/SMT/Z3/DATS/z3.dats"

staload "prelude/SATS/array.sats"

staload "prelude/DATS/array.dats"

staload "prelude/DATS/arrayptr.dats"
staload "libats/SATS/dynarray.sats"

staload "prelude/DATS/arrayptr.dats"
staload "prelude/DATS/array.dats"
staload "libats/DATS/dynarray.dats"
staload "prelude/DATS/integer.dats"
staload "prelude/DATS/pointer.dats"
staload "prelude/DATS/unsafe.dats"

implement main () = 0 where {
  val conf = Z3_mk_config()
  //
  val ctx = Z3_mk_context_rc(conf)
  val _ = Z3_del_config(conf)
  //
  val qf_lia = Z3_mk_tactic(ctx, "qf_lia")
  val solve = Z3_mk_solver_from_tactic(ctx, qf_lia)
  val _ = Z3_tactic_dec_ref(ctx, qf_lia)
  //
  val integers = Z3_mk_int_sort(ctx)
  val one = Z3_mk_int (ctx, 1, integers)
  val two = Z3_mk_int (ctx, 2, integers)
  val x = Z3_mk_fresh_const (ctx, "x", integers)
  val y = Z3_mk_fresh_const (ctx, "y", integers)
  val _ = Z3_sort_dec_ref (ctx, integers)
  //
  val x2 = Z3_mk_mul2(ctx, two, x)
  val y2 = Z3_mk_mul2(ctx, two, y)
  //
  val () = begin
    Z3_dec_ref(ctx, x);
    Z3_dec_ref(ctx, y);
    Z3_dec_ref(ctx, two);
  end
  //
  val args = dynarray_make_nil<Z3_ast>(g1uint2uint_uint_size(2u))
  var tmp : Z3_ast
  val b = dynarray_insert_at<Z3_ast>(args, g1uint2uint_uint_size(0u), x2, tmp)
  val () = assertloc (~b)
  prval () = opt_unnone(tmp)
  //
  val b = dynarray_insert_at<Z3_ast>(args, g1uint2uint_uint_size(1u), y2, tmp)
  val () = assertloc (~b)
  prval () = opt_unnone(tmp)
  //
  val sum = Z3_mk_add(ctx, args)
  //
  var len : size_t
  val contents = dynarray_getfree_arrayptr {Z3_ast} (args, len)
  //
  (* This guy isn't instantiated during compilation. *)
  implement array_uninitialize_env$clear<Z3_ast><Z3_context>(i, x, ctx') = Z3_dec_ref(ctx', x)
  //
  val _ = arrayptr_uninitialize_env<Z3_ast><Z3_context>(contents, len, ctx)
  val _ = arrayptr_free{Z3_context?}(contents)
  //
  val equation = Z3_mk_eq(ctx, sum, one)
  val () = begin
    Z3_dec_ref(ctx, one);
    Z3_dec_ref(ctx, sum);
  end
  val () = Z3_solver_assert(ctx, solve, equation)
  val () = Z3_dec_ref(ctx, equation)
  val ans = Z3_solver_check(ctx, solve)
  val () = println!("2x + 2y = 1: ",ans)
  //
  val _ = Z3_solver_dec_ref (ctx, solve)
  val _ = Z3_del_context (ctx)
}