(* ****** ****** *)
//
// HX-2014-01-25:
// stampseq-indexed lists
//
(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)
//
abstype T(x:stamp)
//
(* ****** ****** *)
//
fun lt_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 < x2)
fun lte_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 <= x2)
fun gt_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 > x2)
fun gte_T_T
  {x1,x2:stamp} (T(x1), T(x2)): bool (x1 >= x2)
fun compare_T_T
  {x1,x2:stamp} (T(x1), T(x2)): int (sgn(x1-x2))
//
overload < with lt_T_T
overload <= with lte_T_T
overload > with gt_T_T
overload >= with gte_T_T
//
overload compare with compare_T_T
//
(* ****** ****** *)
//
datatype
list (stmsq, int) =
  | list_nil (nil, 0)
  | {xs:stmsq}{x:stamp}{n:nat}
    list_cons (cons (x, xs), n+1) of (T(x), list (xs, n))
//
(* ****** ****** *)

fun list_nth
  {xs:stmsq}{n:int}{i:nat | i < n}
  (xs: list (xs, n), i: int (i)): T (select(xs, i))
// end of [list_nth]

(* ****** ****** *)

fun list_append
  {xs,ys:stmsq}{m,n:nat}
  (list (xs, m), list (ys, n)) : list (append(xs, m, ys, n), m+n)

(* ****** ****** *)

fun list_revapp
  {xs,ys:stmsq}{m,n:nat}
  (list (xs, m), list (ys, n)) : list (revapp(xs, m, ys, n), m+n)

(* ****** ****** *)

(* end of [list.sats] *)
