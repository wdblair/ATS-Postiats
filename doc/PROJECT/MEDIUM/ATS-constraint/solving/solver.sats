(*
  A generic wrapper around an SMT sovler for the purpose
  of typechecking.
*)

staload "constraint.sats"
staload "solving/smt.sats"

datatype s3ubexp =
  | S3UBsizeof of (s2zexp)
  | S3UBcst of (s2cst)
  | S3UBapp of (s2cst, s2explst)
  
fun s3ubexp_get_srt (s3ubexp): s2rt

fun s3ubexp_syneq (s3ubexp, s3ubexp): bool

fun s3ubexp_sizeof (s2zexp): s3ubexp
fun s3ubexp_cst (s2cst): s3ubexp
fun s3ubexp_app (s2cst, s2explst): s3ubexp

absviewt@ype smtenv_viewtype = @{
  smt= ptr,
  variables= @{
    statics= ptr,
    substitutes= ptr
  },
  sorts= @{
    integer= ptr,
    boolean= ptr
  },
  err= int
}

viewtypedef smtenv = smtenv_viewtype

fun smtenv_nil (env: &smtenv? >> smtenv): void
fun smtenv_free (env: &smtenv >> smtenv?): void

absview smtenv_push_v

fun formula_from_substitution (env: &smtenv, sub: s3ubexp): formula

fun smtenv_find_substitution (env: &smtenv, sub: s3ubexp): Option (s2var)
fun smtenv_make_substitution (env: &smtenv, sub: s3ubexp, s2v: s2var): void

fun smtenv_push (env: &smtenv): (smtenv_push_v | void)
fun smtenv_pop  (pf: smtenv_push_v | env: &smtenv): void

fun smtenv_add_svar (env: &smtenv, s2v: s2var): void
fun smtenv_get_var_exn (env: &smtenv, s2v: s2var): formula
fun smtenv_assert_sbexp (env: &smtenv, s2e: s2exp): void

fun smtenv_formula_is_valid (env: &smtenv, fm: formula): bool

fun smtenv_assert_formula (env: &smtenv, fm: formula): void

fun formula_cst (s2c: s2cst): formula

(* ****** ****** *)

fun s2exp_metdec_reduce (
  met: s2explst, met_bound: s2explst
): s2exp

(* ****** ****** *)

fun s2exp_make_h3ypo (env: &smtenv, h3p: h3ypo): s2exp
//
fun formula_make (env: &smtenv, s2e: s2exp): formula
//
fun make_true (env: &smtenv): formula
//
fun s2exp_make_h3ypo (env: &smtenv, h3p: h3ypo): s2exp
//
fun formula_make (env: &smtenv, s2e: s2exp): formula
//
// HX: these are auxiliary functions
//
fun formula_make_s2cst_s2explst
(
  env: &smtenv, s2c: s2cst, s2es: s2explst
) : formula // end of [s3exp_make_s2cst_s2explst]

(* ****** ****** *)

fun c3nstr_solve (c3t: c3nstr): void

(* ****** ****** *)

abstype s2cstmap (a:t@ype) = ptr

fun {a:t@ype}
s2cstmap_nil (): s2cstmap (a)

fun {a:t@ype} 
s2cstmap_find (store: s2cstmap (a), key: s2cst): a

fun {a:t@ype}
s2cstmap_add (store: s2cstmap (a), key: s2cst, itm: a): s2cstmap (a)

(* ****** ****** *)

absvtype s2cfunmap = ptr

fun constraint3_initialize (): void

(* ****** ****** *)

fun f_identity (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neg_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_add_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_mul_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_eq_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neq_bool_bool (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neg_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_add_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_sub_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_mul_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_div_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_ndiv_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_idiv_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_lt_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_lte_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_gt_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_gte_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_eq_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_neq_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_abs_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_sgn_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_max_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_min_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_ifint_bool_int_int (
  env: &smtenv, s2es: s2explst
) : formula

fun f_lte_cls_cls (
  env: &smtenv, s2es: s2explst
) : formula