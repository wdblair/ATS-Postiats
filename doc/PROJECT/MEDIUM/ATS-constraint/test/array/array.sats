datasort array = (*abstract*)

(*
  I want to express constraints like the following
  
  (select a i) <= (select a (- n 1))
  
  The SMT solver needs this constraint  to know that then swapping the
  ith element with our pivot index maintains the partition invariant.
*)
stacst array_select : (array, int(*index*)) -> int
stadef select = array_select

stacst swap : (array, int, int) -> array

stacst partitioned_array : (
  array, int(*start*), int (*pivot*), int(*stop*)
) -> bool
stadef partitioned = partitioned_array

stacst sorted_array : (array, int(*begin*), int(*end*)) -> bool
stadef sorted = sorted_array

abstype array (l:addr, a:t@ype, n:int, buf: array) = ptr

(* ****** ****** *)

(*
  Using a  homomorphism between a  t@ype a and an integer, I  can use
  just arrays of integers in the statics.
*)
abst@ype stamp (a:t@ype, i: int) = a

fun {a:t@ype}
stamp_lte {i,j:int} (stamp (a, i), stamp(a, j)): bool (i <= j)

overload <= with stamp_lte

fun {a:t@ype}
array_select {l:addr} {buf:array} {i,n:nat | i < n} (
  array (l, a, n, buf), int i
): stamp (a, select (buf, i))

overload [] with array_select

(* ****** ****** *)

fun {a:t@ype}
quicksort {l:addr} {buf:array} {n:int} (
  array(l, a, n, buf), int n
): [buf': array | sorted (buf', 0, n-1)] array(l, a, n, buf')