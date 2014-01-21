datasort array = (*abstract*)

(*
  The following type  is needed to reason about  elements at different
  indicies in an  array. For example, I want to  capture the following
  constraint
  
  (select a i) <= (select a (- n 1))
  
  The SMT solver needs this constraint  to know that then swapping the
  ith element with our pivot index maintains the partition invariant.

  I think I  might still be able  to express using just int  and not a
  new sort.
*)
datasort select = (*abstract*)

stacst array_select : (array, int(*index*)) -> select
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

stacst lte_select_select: (select, select) -> bool
stadef <= = lte_select_select

abst@ype read (a:t@ype, s:select) = a

fun {a:t@ype}
read_lte {i,j:select} (read (a, i), read (a, j)): bool (i <= j)

overload <= with read_lte

fun {a:t@ype}
array_select {l:addr} {buf:array} {i,n:nat | i < n} (
  array (l, a, n, buf), int i
): read (a, select (buf, i))

overload [] with array_select

(* ****** ****** *)


fun {a:t@ype}
array_split {l:addr} {buf: array} {i,n:nat | i < n} (
  array (l, a, n, buf), int i
): [left,right:array]
  (array (l, a, i+1, left), array (l + sizeof(a) * i, a, n - (i + 1), right))
  
(* ****** ****** *)

fun {a:t@ype}
quicksort_sub_array {l:addr} {n:nat} {buf: array}
   {start,stop:nat | stop < n} (
  &array (l, a, n, buf) >> array(l, a, n, buf'),
  int start, int stop
): #[buf': array | sorted (buf', start, stop)] void

fun {a:t@ype}
quicksort {l:addr} {buf:array} {n:nat} (
  &array(l, a, n, buf) >> array(l, a, n, buf'), int n
): #[buf: array | sorted(buf', 0, n-1)] void