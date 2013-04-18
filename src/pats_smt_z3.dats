staload "pats_smt.sats"

(* ****** ****** *)

local
  abstype config
  
  extern
  fun Z3_mk_true(_: !context): formula = "mac#"
  
  extern
  fun Z3_mk_false(_: !context): formula = "mac#"
  
  extern
  fun Z3_mk_eq(
    _: !context, _: formula, _:formula
  ): formula = "mac#"

  extern
  fun Z3_mk_not (
    _: !context, _: formula
  ): formula = "mac#"

  extern
  fun Z3_mk_and {n:pos} (
    _: !context, _: int n, _: &(@[ptr][n])
  ): formula = "mac#"
  
  extern
  castfn ptr_of_formula(_: formula): ptr
  
in
  implement make_context () = ctx where {
    val conf = $extfcall(config, "Z3_mk_config")
    val ctx = $extfcall(context, "Z3_mk_context_rc", conf)
  }
  
  extern
  castfn __copy(_: !formula): formula
  
  extern
  fun Z3_inc_ref(_: !context, _: !formula): void = "mac#"
    
  implement copy_formula (ctx, wff) = wff' where {
    val _ = Z3_inc_ref(ctx, wff)
    val wff' = __copy(wff)
  }
   
  implement make_true(ctx) = wff where {
    val wff = Z3_mk_true(ctx)
    val _ = Z3_inc_ref(ctx, wff)
  }
  
  implement make_false(ctx) = wff where {
    val wff = Z3_mk_false(ctx)
    val _ = Z3_inc_ref(ctx, wff)
  }

  implement make_eq(ctx, l, r) = wff where {
    val wff = Z3_mk_eq(ctx, l, r)
    val _ = Z3_inc_ref(ctx, wff)
  }

  implement make_not(ctx, phi) = psi where {
    val psi = Z3_mk_not(ctx, phi)
    val _ = Z3_inc_ref(ctx, psi)
  }
  
  implement make_and(ctx, l, r) = wff where {
    var buf : @[ptr][2]
    val () = buf.[0] := ptr_of_formula(l)
    val () = buf.[1] := ptr_of_formula(r)
    val wff = Z3_mk_and(ctx, 2, buf)
  }
end

(* ****** ****** *)