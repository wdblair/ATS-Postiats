staload "pats_smt.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/list_vt.dats"
staload  "prelude/DATS/array.dats"
staload  "prelude/DATS/integer.dats"

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

%{^
void * __make_mul (void *context, void *left, void *right) {
  Z3_ast buf[2];
  buf[0] = (Z3_ast) left;
  buf[1] = (Z3_ast) right;
  return Z3_mk_mul((Z3_context) context, 2, buf);
}
%}

local

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

  typedef binop_func = {n:nat} (
    context, int n, &(@[formula][n])
  ) -> formula
  
  (*
    Z3 uses the same pattern for a few binary operators
  *)
  
  fun make_binop (
    solve: !solver, wffs: List_vt(formula), func: binop_func
  ): formula = res where {
    val len = list_vt_length(wffs)
    val ()  = assertloc(len >= 0)
    val len' = size1_of_int1(len)  //need some shorthand, like (size)
    val (pf | p, free) = array_ptr_allocfree<formula>(len')
    val () = array_ptr_initialize_lst_vt<formula>(!p, wffs)
    //
    val res = func(solve.ctx, len, !p)
    val () = free(pf | p)
    val _ = Z3_inc_ref(solve.ctx, res)
    //
  }
in
  implement make_solver () = solve where {
    extern fun Z3_mk_config(): config = "mac#"
    extern fun Z3_mk_context_rc(_: config): context = "mac#"
    extern fun Z3_mk_solver(_: context): z3_solver = "mac#"
    //
    val conf = Z3_mk_config ()
    val ctx = Z3_mk_context_rc(conf)
    val z3solve = Z3_mk_solver(ctx)
    val solve = '{ctx= ctx, slv= z3solve}
  }
  
  implement delete_solver (solve) = {
    extern fun Z3_del_context(_: context): void = "mac#"
    //
    val () = Z3_del_context(solve.ctx)
    prval _ = __free(solve) where {
      extern
      praxi __free (_: solver): void
    }
  }
  
  implement make_int_sort (solve) = srt where {
    extern fun Z3_mk_int_sort (_: context): sort = "mac#"
    //
    val srt = Z3_mk_int_sort (solve.ctx)
  }
  
  implement make_int_symbol (solve, id) = sym where {
    extern fun Z3_mk_int_symbol (_: context, _: int): symbol = "mac#"
    //
    val sym = Z3_mk_int_symbol (solve.ctx, id)
  }
  
  implement make_constant (solve, sym, srt) = cst where {
    extern fun Z3_mk_const (
      _: context, _: symbol, _: sort
    ): formula = "mac#"
    //
    val cst = Z3_mk_const (solve.ctx, sym, srt)
    val _ = Z3_inc_ref(solve.ctx, cst)
  }
  
  (* ****** ****** *)
  
  implement make_not (solve, phi) = psi where {
    extern fun Z3_mk_not (_: context, _: formula): formula = "mac#"
    //
    val psi = Z3_mk_not (solve.ctx, phi)
    val _ = Z3_inc_ref (solve.ctx, psi)
  }
  
  implement make_or (solve, wffs) = 
    make_binop (solve, wffs, Z3_mk_or)
  
  implement make_and (solve, wffs) =
    make_binop (solve, wffs, Z3_mk_and)
    
  (* ****** ****** *)
  
  implement make_numeral (solve, str, srt) = num where {
    extern fun Z3_mk_numeral (
      _: context, _: string, _: sort
    ): formula = "mac#"
    //
    val num = Z3_mk_numeral(solve.ctx, str, srt)
    val _ = Z3_inc_ref(solve.ctx, num)
  }
  
  implement make_add (solve, wffs) = make_binop(solve, wffs, Z3_mk_add)
  
  implement make_lt (solve, l, r) = wff where {
    extern fun Z3_mk_lt (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_lt (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_le (solve, l, r) = wff where {
    extern fun Z3_mk_le (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_le (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_gt (solve, l, r) = wff where {
    extern fun Z3_mk_gt (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_gt (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_ge (solve, l, r) = wff where {
    extern fun Z3_mk_ge (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_ge (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }

  implement make_eq (solve, l, r) = wff where {
    extern fun Z3_mk_eq (
      _: context, _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = Z3_mk_eq (solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }
  
  implement make_mul (solve, l, r) = wff where {
    val wff = __make_mul(solve.ctx, l, r)
    val _ = Z3_inc_ref(solve.ctx, wff)
  }
  
  (* ****** ****** *)
  
  implement assert (solve, formula) = {
    extern fun Z3_solver_assert (
      _: context, _: z3_solver, _: formula
    ): void = "mac#"
    //
    val _ = Z3_solver_assert(solve.ctx, solve.slv, formula)
  }
  
  macdef Z3_FALSE = $extval(int, "Z3_L_FALSE")
  macdef Z3_TRUE = $extval(int, "Z3_L_TRUE")
  
  implement check (solver) = let
    extern fun Z3_solver_check (
      _: context, _: z3_solver
    ): [s:status] int s = "mac#"
    //
    val res = Z3_solver_check (solver.ctx, solver.slv)
  in
    case+ res of 
      | _ when res = Z3_FALSE => ~1
      | _ when res = Z3_TRUE => 0
      | _ =>> 0 //unknown might as well mean invalid
  end 
  
  (* ****** ****** *)
  
  implement string_of_formula (solver, wff) = expr where {
    extern fun Z3_ast_to_string (
      _: context, _: formula
    ): string = "mac#"
    //
    val expr = Z3_ast_to_string (solver.ctx, wff)
  }
end