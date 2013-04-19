staload "pats_smt.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/list_vt.dats"
staload _ = "prelude/DATS/array.dats"
staload _ = "prelude/DATS/integer.dats"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

// A simple wrapper around Z3 for the constraint solver.
// This is implemented in Postiats

(* ****** ****** *)

abstype config = ptr
abstype context = ptr
abstype z3_solver = ptr

assume solver = '{
  ctx= context,
  slv= z3_solver
}

%{
void * __make_mul (void *context, void *left, void *right) {
  Z3_ast buf[2];
  buf[0] = (Z3_ast) left;
  buf[1] = (Z3_ast) right;
  return Z3_mk_mul((Z3_context) context, 2, buf);
}
%}

local
  extern
  fun Z3_mk_eq (
    _: context, _: formula, _:formula
  ): formula = "mac#"
  
  extern
  fun Z3_mk_not (
    _: context, _: formula
  ): formula = "mac#"

  extern
  fun Z3_mk_and {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_mk_or {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun Z3_mk_add {n:nat} (
    _: context, _: int n, _: &(@[formula][n])
  ): formula = "mac#"
  
  extern
  fun __make_mul (
    _: context, _: formula, _: formula
  ): formula = "mac#"
  
  extern
  fun Z3_inc_ref (
    _: context, _: formula
  ): void = "mac#"
  
  (* ****** ****** *)
  
  sortdef binop = tkind
  
  stacst disj  : binop
  stacst conj  : binop
  stacst plus  : binop

  typedef binop_func = {n:nat} (
    context, int n, &(@[formula][n])
  ) -> formula
  
  (*
    Z3 uses the same pattern for a few binary operators
  *)
  extern
  fun {func: binop} z3_operator (): binop_func

  implement z3_operator<disj>() = Z3_mk_or
  implement z3_operator<conj>() = Z3_mk_and
  implement z3_operator<plus>() = Z3_mk_add
 
  fun {func: binop} make_binop (
    solve: solver, wffs: List_vt(formula)
  ): formula = res where {
    val len = list_vt_length(wffs)
    val ()  = assertloc(len >= 0)        //a length < 0 doesn't make any sense.
    val len' = g1int2uint_int_size(len)  //need some shorthand, like (size)
    val (pf, free_gc | p) = array_ptr_alloc<formula>(len')
    prval pf = array_of_array_v(pf)
    val () = array_copy_from_list_vt<formula>(!p, wffs)
    //
    val func = z3_operator<func>()
    val res = func(solve.ctx, len, !p)
    val _ = Z3_inc_ref(solve.ctx, res)
    //
    prval pf = array_v_of_array(pf)
    val () = array_ptr_free(pf, free_gc | p)
  }
  
  sortdef comp: tkind
  
  stacst lt : comp
  stacst le : comp
  stacst gt : comp
  stacst ge : comp
  stacst eq : comp
  
  //comparison operators
  extern
  fun {func: 
  
in
  implement make_solver () = solve where {
    val conf = $extfcall(config, "Z3_mk_config")
    val ctx = $extfcall(context, "Z3_mk_context_rc", conf)
    val z3solve = $extfcall(z3_solver, "Z3_mk_solver", ctx)
    val solve = '{ctx= ctx, slv= z3solve}
  }
  
  implement delete_solver (solve) = {
    val () = $extfcall(void, "Z3_del_context", solve.ctx)
    val _ = __free(solve) where {
      extern
      fun __free (_: solver): void = "mac#free"
    }
  }
  
  implement make_int_sort (solve) = srt where {
    val srt = $extfcall(sort, "Z3_mk_int_sort", solve.ctx)
  }
  
  (* ****** ****** *)
  
  implement make_not (solve, phi) = psi where {
    val psi = $extfcall(formula, "Z3_mk_not", solve.ctx, phi)
    val _ = Z3_inc_ref(solve.ctx, psi)
  }
  
  implement make_or (solve, wffs) = make_binop<disj>(solve, wffs)
  
  implement make_and (solve, wffs) = make_binop<conj>(solve, wffs)

  (* ****** ****** *)
  
  implement make_numeral (solve, str, srt) = num where {
    val num = $extfcall(formula, "Z3_mk_numeral", solve.ctx, str, srt)
    val _ = Z3_inc_ref(solve.ctx, num)
  }
  
  implement make_add (solve, wffs) = make_binop<plus>(solve, wffs)

  implement make_eq (solve, l, r) = wff where {
    val wff = $extfcall(formula, "Z3_mk_eq", solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_mul (solve, l, r) = wff where {
    val wff = __make_mul(solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }
  
  implement make_lt (solve, l, r) = wff where {
    val wff = $extfcall(formula, "Z3_mk_lt"
  }
end

(* ****** ****** *)
