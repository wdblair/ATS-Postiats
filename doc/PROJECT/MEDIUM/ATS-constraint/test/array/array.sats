datasort array = (*abstract*)

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
stadef sorted (a:array, n:int) = sorted_array (a, 0, n)
stadef sorted_range (a: array, offs: int, n:int) = sorted_array (a, offs, n)

(*
  example:
  sorted_split_array (0, j+1, i)
  
  The meaning  of this predicate  is that  the sub array  i in
  [0,j] is sorted and at i is less then or equal to an element
  k in (j+1,i]. This allows us to slide the current value into
  its  sorted position  and state  the final  array is  indeed
  sorted from the interval i-1+1 = i
*)
stacst sorted_split_array : (
  array, int(*begin*), int(*pivot*), int(*end*)
) -> bool
stadef sorted_split = sorted_split_array

abstype array (a:t@ype, n:int, buf: array) = ptr

(* ****** ****** *)

abst@ype stamp (a:t@ype, i:int) = a

fun {a:t@ype}
stamp_lte {i,j:int} (stamp (a, i), stamp(a, j)): bool (i <= j)

overload <= with stamp_lte

fun {a:t@ype}
array_select {buf:array} {i,n:nat | i < n} (
  array (a, n, buf), int i
): stamp (a, select (buf, i))

fun {a:t@ype}
array_store {buf:array} {i,n:nat | i < n} {v:int} (
  array (a, n, buf), int i, stamp (a, v)
): array (a, n, store(buf, i, v))

overload [] with array_select

fun {a:t@ype} swap {buf:array} {i,j,n:int} (
  array (a, n, buf), int i, int j
): array (a, n, swap (buf,i,j))

(* ****** ****** *)