(* ****** ****** *)
//
// HX-2014-01-25:
// stampseq-indexed arrays
//
(* ****** ****** *)

staload "./stampseq.sats"

(* ****** ****** *)
//
abst@ype T(a:t@ype, x:stamp) = a
//
(* ****** ****** *)
//
fun {a:t@ype} lt_T_T
  {x1,x2:stamp} (T(a, x1), T(a, x2)): bool (x1 < x2)
fun {a:t@ype} lte_T_T
  {x1,x2:stamp} (T(a, x1), T(a, x2)): bool (x1 <= x2)
fun {a:t@ype} gt_T_T
  {x1,x2:stamp} (T(a, x1), T(a, x2)): bool (x1 > x2)
fun {a:t@ype} gte_T_T
  {x1,x2:stamp} (T(a, x1), T(a, x2)): bool (x1 >= x2)
fun {a:t@ype} compare_T_T
  {x1,x2:stamp} (T(a, x1), T(a, x2)): int (sgn(x1-x2))
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
fun {a:t@ype} add_ptr_int
  {l:addr}{i:int} (ptr l, int i):<> ptr (l+sizeof(a)*i)
fun {a:t@ype} sub_ptr_int
  {l:addr}{i:int} (ptr l, int i):<> ptr (l-sizeof(a)*i)
fun {a:t@ype} succ_ptr_t0ype
  {l:addr} (ptr l):<> ptr (l+sizeof(a))
//
overload + with add_ptr_int
overload - with sub_ptr_int
//
(* ****** ****** *)

(**
  This variant of ptr_get is missing from 
  the prelude and just using the "!" operator
  does not find the right view
*)
fun {a:t@ype}
ptr_get0{l:addr}{x:stamp}
  (pf: !INV(T(a,x)) @ l | p: ptr l):<> T(a,x)
// end of [ptr_get0]

fun {a:t@ype} ptr_offset 
  {l:addr}{i:nat} (ptr (l+i*sizeof(a))):<> int (i)

(* ****** ****** *)

dataview
array_v
  (a:t@ype, addr, stmsq, int) =
  | {l:addr}
    array_v_nil (a, l, nil, 0) of ()
  | {l:addr}{xs:stmsq}{x:stamp}{n:int}
    array_v_cons (a, l, cons (x, xs), n+1) of (
      T(a, x) @ l, array_v (a, l+sizeof(a), xs, n)
    )
// end of [array_v]

(* ****** ****** *)

prfun
array_v_split
  {a:t@ype}{l:addr}{xs:stmsq}
  {n:int}{i:nat | i <= n}
(
  pf: array_v(a, l, xs, n), i: int (i)
) : (
  array_v (a, l, take(xs, i), i)
, array_v (a, l + sizeof(a)*i, drop(xs, i), n-i)
) (* end of [array_v_split] *)

(* ****** ****** *)

prfun
array_v_unsplit
  {a:t@ype}{l:addr}
  {xs1,xs2:stmsq}
  {n1,n2:int}
(
  pf1: array_v(a, l, xs1, n1)
, pf2: array_v(a, l+sizeof(a)*n1, xs2, n2)
) :
(
  array_v (a, l, append (xs1, n1, xs2, n2), n1+n2)
) (* end of [array_v_unsplit] *)

(* ****** ****** *)

fun {a:t@ype} array_ptrget
  {l:addr}{xs:stmsq}
  {n:int}{i:nat | i < n}
  (pf: !array_v(a, l, xs, n) | p: ptr(l+i*sizeof(a))) : T(a, select(xs, i))
// end of [array_ptrget]

fun array_ptrset
  {a:t@ype}{l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(a, l, xs, n) >> array_v (a, l, update (xs, i, x), n) | p: ptr(l+sizeof(a)*i), x: T(a, x)
) : void // end of [array_ptrset]

(* ****** ****** *)
//
fun {a:t@ype} array_get_at
  {l:addr}{xs:stmsq}
  {n:int}{i:nat | i < n}
  (pf: !array_v(a, l, xs, n) | p: ptr(l), i: int i) : T(a, select(xs, i))
// end of [array_get_at]
//
fun {a:t@ype} array_set_at
  {l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(a, l, xs, n) >> array_v (a, l, update(xs, i, x), n) | p: ptr(l), i: int i, x: T(a, x)
) : void // end of [array_set_at]
//
(* ****** ****** *)

fun{a:t@ype} array_ptrswap
  {l:addr}
  {xs:stmsq}
  {n:int}{i,j:nat | i < n; j < n}
(
  pf: !array_v(a, l, xs, n) >> array_v (a, l, swap_at(xs, i, j), n) | p1: ptr(l+i*sizeof(a)), p2: ptr(l+j*sizeof(a))
) : void // end of [array_ptrswap]

(* ****** ****** *)

(* end of [array.sats] *)
