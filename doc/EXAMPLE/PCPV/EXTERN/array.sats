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
fun {} add_ptr_int
  {a:t@ype}{l:addr}{i:int} (ptr l, size_t (i)):<> ptr (l+sizeof(a)*i)
fun {} succ_ptr_t0ype
  {a:t@ype} {l:addr} (ptr l):<> ptr (l+sizeof(a))
//
overload + with add_ptr_int

fun eq_ptr_int
  {a:t@ype}{l:addr}{i,j:int} (ptr (l+i*sizeof(a)), ptr(l+j*sizeof(a))): bool (i == j) = "mac#"
  
%{#
#define eq_ptr_int(p, q) (p == q)
%}

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

fun {} ptr_offset
  {a:t@ype}{l:addr}{i:nat} (ptr l, ptr (l+i*sizeof(a))):<> size_t (i)

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
  pf: array_v(a, l, xs, n), i: size_t (i)
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

fun {a:t@ype} array_ptrset
  {l:addr}
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
  (pf: !array_v(a, l, xs, n) | p: ptr(l), i: size_t (i)) : T(a, select(xs, i))
// end of [array_get_at]
//
fun {a:t@ype} array_set_at
  {l:addr}
  {xs:stmsq}{x:stamp}
  {n:int}{i:nat | i < n}
(
  pf: !array_v(a, l, xs, n) >> array_v (a, l, update(xs, i, x), n) | p: ptr(l), i: size_t (i), x: T(a, x)
) : void // end of [array_set_at]
//
(* ****** ****** *)

fun {} array_ptrswap
  {a:t@ype}
  {l:addr}
  {xs:stmsq}
  {n:int}{i,j:nat | i < n; j < n}
(
  pf: !array_v(a, l, xs, n) >> array_v (a, l, swap_at(xs, i, j), n) | p1: ptr(l+i*sizeof(a)), p2: ptr(l+j*sizeof(a))
) : void // end of [array_ptrswap]

(**
  I'm adding this because the size of a type
  could be provided in some places as an automatic variable like
  in the libc qsort function.
  
  For example, suppose a function takes the size of the type to be
  worked on, stored in a variable sz. When the user goes to sort
  this list, they just do:
  
  implement sizeof_t0ype() = sz
*)
fun {}
sizeof_t0ype {a:t@ype} ():<> size_t (sizeof(a))

(* ****** ****** *)

(* end of [array.sats] *)
