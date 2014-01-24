datasort array = (*abstract*)

(*
  I want to express constraints like the following
  
  (select a i) <= (select a (- n 1))
  
  The SMT solver needs this constraint  to know that then swapping the
  ith element with our pivot index maintains the partition invariant.
*)
stacst array_select : (array, int(*index*)) -> int
stadef select = array_select

stacst array_store  : (array, int(*index*), int (*v*)) -> array
stadef store = array_store

stacst array_swap : (array, int, int) -> array
stadef swap = array_swap

stacst partitioned_array : (
  array, int(*start*), int (*pivot*), int(*stop*)
) -> bool
stadef partitioned = partitioned_array

stacst sorted_array : (array, int(*begin*), int(*end*)) -> bool
//stadef sorted = sorted_array
stadef sorted (a:array, n:int) = sorted_array (a, 0, n)
stadef sorted_range (a: array, offs: int, n:int) = sorted_array (a, offs, n)

stacst sorted_split_array : (array, int(*begin*), int(*pivot*), int(*end*)) -> bool
stadef sorted_split = sorted_split_array

abstype array (l:addr, a:t@ype, n:int, buf: array) = ptr

(* ****** ****** *)

abst@ype stamp (a:t@ype, i:int) = a

fun {a:t@ype}
stamp_lte {i,j:int} (stamp (a, i), stamp(a, j)): bool (i <= j)

overload <= with stamp_lte

fun {a:t@ype}
array_select {l:addr} {buf:array} {i,n:nat | i < n} (
  array (l, a, n, buf), int i
): stamp (a, select (buf, i))

fun {a:t@ype}
array_store {l:addr} {buf:array} {i,n:nat | i < n} {v:int} (
  array (l, a, n, buf), int i, stamp (a, v)
): array (l, a, n, store(buf, i, v))

overload [] with array_select

fun {a:t@ype} swap {l:addr} {buf:array} {i,j,n:int} (
  array (l, a, n, buf), int i, int j
): array (l, a, n, swap (buf,i,j))

(* ****** ****** *)