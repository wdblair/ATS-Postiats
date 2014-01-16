datasort array = (*abstract*)

(*
  The following type is needed to reason about
  elements at different indicies in an array. For example,
  I want to capture the following constraint
  
  (select a i) <= (select a (- n 1))
  
  The SMT solver needs this constraint to know that 
  then swapping the ith element with our pivot index
  maintains the partition invariant.
*)
datasort array_read = (*abstract*)

stacst array_select : (array, int(*index*)) -> array_read
stadef select = array_select

stacst swap : (array, int, int) -> array

stacst partitioned_array : (
  array, int(*start*), int (*pivot*), int(*stop*)
) -> bool
stadef partitioned = partitioned_array

stacst sorted_array : (array, int(*begin*), int(*end*)) -> bool
stadef sorted = sorted_array

abstype array (a:t@ype, n:int, buf: array) = ptr

(* ****** ****** *)

stacst lte_array_read_array_read: (array_read, array_read) -> bool
stadef <= = lte_array_read_array_read

abst@ype read (a:t@ype, rs:array_read) = a

fun {a:t@ype} {i,j:array_read}
read_lte (read (a, i), read (a, j)): bool (i <= j)

overload <= with read_lte

fun {a:t@ype}
array_select {buf:array} {i,n:nat | i < n} (
  array (a, n, buf), int i
): read (a, select (buf, i))

overload [] with array_select

(* ****** ****** *)

fun {a:t@ype}
quicksort_sub_array {n:int} {buf: array}
   {start,stop:int} (
  &array(a, n, buf) >> array(a, n, buf'),
  int start, int stop
): #[buf':array | sorted(buf', start, stop)] void

fun {a:t@ype}
quicksort {buf:array} {n:nat} (
  &array(a, n, buf) >> array(a, n, buf'), int n
): #[buf':array | sorted(buf', 0, n-1)] void