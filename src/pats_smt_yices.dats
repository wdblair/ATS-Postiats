staload "pats_smt.sats"
staload "pats_lintprgm.sats"
staload "libc/SATS/gmp.sats"

(* ****** ****** *)

staload _ = "prelude/DATS/list_vt.dats"
staload _ =  "prelude/DATS/array.dats"
staload _ =  "prelude/DATS/integer.dats"

staload "pats_lintprgm_myint_intinf.dats"

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

// Seeing how Yices does as a constraint solver
// TODO: Yices has a way to generate polynomials, 
// which is all we really want.

(* ****** ****** *)

abstype config = ptr
abstype context = ptr

(* ****** ****** *)

assume formula = int
assume sort = int

assume config = ptr
assume context = ptr
assume solver = context

(* ****** ****** *)

local
  
  (* ****** ****** *)
  
  extern fun yices_init(): void = "mac#"
  extern fun yices_exit(): void = "mac#"
  
  extern fun yices_new_config (): config = "mac#"
  extern fun yices_free_config (_: config): void = "mac#"

  extern fun yices_default_config_for_logic (
    _: config, _: string
  ): int = "mac#"
  
  extern fun yices_print_error(_: FILEref): int = "mac#"
  
  (* ****** ****** *)
  
  extern fun yices_new_context (_: config): context = "mac#"
  extern fun yices_free_context (_: context): void = "mac#"
  
  (* ****** ****** *)
  
  typedef binop_func = {n:nat} (
    uint n, &(@[formula][n])
  ) -> formula
  
  (* ****** ****** *)
  
  fun make_binop (
    wffs: List_vt(formula), func: binop_func
  ): formula = res where {
    val len = list_vt_length (wffs)
    val ()  = assertloc(len >= 0)
    val len' = size1_of_int1 (len)  //need some shorthand, like (size)
    val (pf | p, free) = array_ptr_allocfree<formula> (len')
    val () = array_ptr_initialize_lst_vt<formula> (!p, wffs)
    //
    val res = func (uint1_of_int1(len), !p)
    val () = assertloc(res > ~1)
    val () = free (pf | p)
    //
  }

  (* ****** ****** *)
  
in
  implement make_solver () = let
    val () = yices_init()
    //
    val conf = yices_new_config ()
    val _ = assertloc(conf > null)
    //
    val err = yices_default_config_for_logic (conf, "QF_LIA")
    val _ = assertloc(err = 0)
    //
    val ctx = yices_new_context (conf)
    val _ = assertloc(ctx > null)
    //
    val () = yices_free_config(conf)
  in
    ctx
  end
  
  implement delete_solver (ctx) = {
    val _ = yices_free_context (ctx)
    val _ = yices_exit()
  }
  
  implement make_int_sort (ctx) = srt where {
    extern fun yices_int_type (): sort = "mac#"
    val srt = yices_int_type ()
    val _ = assertloc(srt > ~1)
  }
  
  implement make_constant (ctx, id, srt) = const where {
    extern fun yices_new_uninterpreted_term (_: sort): formula = "mac#"
    //
    val const = yices_new_uninterpreted_term (srt)
    val _ = assertloc (const > ~1)
  }
  
  (* ****** ****** *)
  
  implement make_and (ctx, wffs) = let
    extern fun yices_and {n:nat} (
       _: uint n, _: &(@[formula][n])
    ): formula = "mac#"
  in
    make_binop(wffs, yices_and)
  end

  implement make_or (ctx, wffs) = let
    extern fun yices_or {n:nat} (
       _: uint n, _: &(@[formula][n])
    ): formula = "mac#"
  in
    make_binop(wffs, yices_or)
  end

  implement make_not (ctx, wff) = wff where {
    extern fun yices_not (_: formula): formula = "mac#"
    //
    val wff = yices_not (wff)
    val _ = assertloc (wff > ~1)
  }
  
  (* ****** ****** *)
  
  implement make_add (ctx, lst) = let
    extern fun yices_zero(): formula = "mac#"
  in
    case+ lst of
      | ~list_vt_nil () => yices_zero()
      | ~list_vt_cons(x, xs) => let
        fun loop (
          xs: List_vt(formula), res: formula
        ): formula = 
          case+ xs of 
            | ~list_vt_nil () => res 
            | ~list_vt_cons(x, xss) => let
              extern fun yices_add (
                _: formula, _: formula
              ): formula = "mac#"
              //
              val res' = yices_add (x, res)
              val _ = assertloc(res' > ~1)
            in loop (xss, res') end
      in loop(xs, x) end
   end
   
   (* ****** ****** *)
   
  implement make_numeral_int (ctx, num, srt) = wff where {
    extern fun yices_int32 (_: int): formula = "mac#"
    //
    val wff = yices_int32 (num)
    val _ = assertloc(wff > ~1)
  }
  
  implement make_mul (ctx, l, r) = wff where {
    extern fun yices_mul (_: formula, _: formula): formula = "mac#"
    //
    val wff = yices_mul (l, r)
    val _ = assertloc (wff > ~1)
  }

  implement make_lt (ctx, l, r) = wff where {
    extern fun yices_arith_lt_atom (
      _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = yices_arith_lt_atom (l, r)
    val _ = assertloc (wff > ~1)
  }
  
  implement make_le (ctx, l, r) = wff where {
    extern fun yices_arith_leq_atom (
      _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = yices_arith_leq_atom (l, r)
    val _ = assertloc (wff > ~1)
  }
    
  implement make_gt (ctx, l, r) = wff where {
    extern fun yices_arith_gt_atom (
      _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = yices_arith_gt_atom (l, r)
    val _ = assertloc (wff > ~1)
  }

  implement make_ge (ctx, l, r) = wff where {
    extern fun yices_arith_geq_atom (
      _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = yices_arith_geq_atom (l, r)
    val _ = assertloc (wff > ~1)
  }

  implement make_eq (ctx, l, r) = wff where {
    extern fun yices_arith_eq_atom (
      _: formula, _: formula
    ): formula = "mac#"
    //
    val wff = yices_arith_eq_atom (l, r)
    val _ = assertloc (wff > ~1)
  }
  
  (* ****** ****** *)
  
  implement assert (ctx, wff) = {
    extern fun yices_assert_formula (
      _: !solver, _: formula
    ): int = "mac#"
    //
    val err = yices_assert_formula (ctx, wff)
    val _ = assertloc(err > ~1)
  }

  macdef SAT = $extval(int, "STATUS_SAT")
  macdef UNSAT = $extval(int, "STATUS_UNSAT")
  macdef UNKNOWN = $extval(int, "STATUS_UNKNOWN")
  
  implement check (ctx) = let
    extern fun yices_check_context (
      _: !solver, _: ptr null
    ): int = "mac#"
    //
    val res = yices_check_context(ctx, null)
  in 
    case+ res of 
      | _ when res = UNSAT => ~1
      | _ when res = SAT => 0
      | _ => 0
  end
end